[CmdletBinding()]
param(
	[string]$SshTarget = "root@100.79.1.53",
	[string]$RemoteBase = "/var/www",
	[string]$Domain = "c0d4.ink"
)

$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot
Push-Location $projectRoot

try {
	$changes = git status --porcelain
	if ($LASTEXITCODE -ne 0) {
		throw "Unable to read the Git working tree."
	}
	if ($changes) {
		throw "The working tree is not clean. Commit or stash changes before deploying."
	}

	$release = (git rev-parse --short=7 HEAD).Trim()
	if ($LASTEXITCODE -ne 0 -or $release -notmatch "^[0-9a-f]{7}$") {
		throw "Unable to determine the release commit."
	}
	if ($RemoteBase -notmatch "^/[A-Za-z0-9._/-]+$") {
		throw "RemoteBase contains unsupported characters."
	}

	Write-Host "Building release $release..." -ForegroundColor Cyan
	& pnpm.cmd build
	if ($LASTEXITCODE -ne 0) {
		throw "The site build failed. Nothing was uploaded."
	}

	$archiveName = "fuwari-$release.tar.gz"
	$localArchive = Join-Path $env:TEMP $archiveName
	$remoteArchive = "/tmp/$archiveName"
	$remoteTarget = "$RemoteBase/fuwari-$release"
	$currentLink = "$RemoteBase/fuwari-current"

	if (Test-Path -LiteralPath $localArchive) {
		Remove-Item -LiteralPath $localArchive -Force
	}

	Write-Host "Packing dist..." -ForegroundColor Cyan
	& tar.exe -czf $localArchive -C dist .
	if ($LASTEXITCODE -ne 0) {
		throw "Unable to create the release archive."
	}

	Write-Host "Uploading $archiveName..." -ForegroundColor Cyan
	& scp.exe $localArchive "${SshTarget}:$remoteArchive"
	if ($LASTEXITCODE -ne 0) {
		throw "Upload failed. The live site was not changed."
	}

	$remoteCommand = @"
set -eu
archive='$remoteArchive'
target='$remoteTarget'
current='$currentLink'
domain='$Domain'
trap 'rm -f "`$archive"' EXIT

if [ -e "`$target" ]; then
    echo "Release directory already exists: `$target" >&2
    exit 2
fi

mkdir "`$target"
tar -xzf "`$archive" -C "`$target"
test -f "`$target/index.html"
find "`$target" -type d -exec chmod 755 {} +
find "`$target" -type f -exec chmod 644 {} +
nginx -t

old_target=`$(readlink -f "`$current" 2>/dev/null || true)
ln -sfn "`$target" "`$current"

if ! systemctl reload nginx || ! curl --noproxy '*' -skf --resolve "`$domain:443:127.0.0.1" "https://`$domain/" -o /dev/null; then
    echo "Health check failed; rolling back." >&2
    if [ -n "`$old_target" ]; then
        ln -sfn "`$old_target" "`$current"
        systemctl reload nginx
    fi
    exit 3
fi

echo "Published: `$(readlink -f "`$current")"
"@

	Write-Host "Activating $remoteTarget..." -ForegroundColor Cyan
	& ssh.exe $SshTarget $remoteCommand
	if ($LASTEXITCODE -ne 0) {
		throw "Remote activation failed. Check the message above."
	}

	Write-Host "Deployment complete: https://$Domain/" -ForegroundColor Green
}
finally {
	if ($localArchive -and (Test-Path -LiteralPath $localArchive)) {
		Remove-Item -LiteralPath $localArchive -Force
	}
	Pop-Location
}

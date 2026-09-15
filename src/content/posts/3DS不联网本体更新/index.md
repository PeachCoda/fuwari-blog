---
title: 3DS不联网本体更新
published: 2026-08-21
description: 老小三，更新至最新系统，可以使用Pokemon Bank
category: other
draft: false
---

# Old 3DS 日版系统更新

适用：】9 0，已安装 Luma3DS，但官方“本体更新”失败。目标版本：`Sys 11.17.0-50J`。

## 1. 确认当前状态

![初始系统版本](C:/Users/c8o1d/Desktop/3DS系统更新教程配图/IMG_20260819_211539.jpg)

系统设置右下角显示 `Sys 11.8.0-41J` 这类字样，说明当前是 SysNAND 日版系统。

![Luma 配置](C:/Users/c8o1d/Desktop/3DS系统更新教程配图/IMG_20260819_212242.jpg)

按住 `SELECT` 开机进入 Luma 配置。建议打开 `Show NAND or user string in System Settings`，然后选 `Save and exit`。

## 2. 先试官方更新

先试：系统设置 -> 其他设置 -> 本体更新。

如果失败，再试恢复模式：关机后按住 `L + R + ↑ + A` 开机更新。

如果恢复模式也失败，继续下面步骤。

## 3. CTRTransfer 修系统底座

![CTRTransfer](C:/Users/c8o1d/Desktop/3DS系统更新教程配图/IMG_20260819_224105.jpg)

按 3DS Hacks Guide 的 CTRTransfer 流程做。老小三日版只选这个包：

`Old 3DS or 2DS - 11.15.0 - JPN - CTRTransfer`

不要选 `New 3DS`，不要选 `USA / EUR / KOR / CHN`。

完成后检查系统版本，应到 `Sys 11.15.0-47J`。

## 4. 用 sysUpdater 离线更新到 11.17

![sysUpdater](C:/Users/c8o1d/Desktop/3DS系统更新教程配图/IMG_20260820_014226.jpg)

在 SD 根目录建 `updates` 文件夹，把 `Old 3DS / JPN / 11.17.0-50J` 更新包里的所有 `.cia` 放进去。

进入 Homebrew Launcher，运行 `sysUpdater`，选择 `Update`。过程中不要关机、不要合盖、不要拔 SD 卡。

## 5. 检查结果

![最终版本](C:/Users/c8o1d/Desktop/3DS系统更新教程配图/IMG_20260820_014627.jpg)

系统设置右下角显示 `Sys 11.17.0-50J` 就完成了。

## 资源链接

- [3DS Hacks Guide: Restoring / Updating CFW](https://3ds.hacks.guide/restoring-updating-cfw.html)
- [3DS Hacks Guide: CTRTransfer](https://3ds.hacks.guide/ctrtransfer.html)
- [Luma3DS Releases](https://github.com/LumaTeam/Luma3DS/releases)
- [GodMode9 Releases](https://github.com/d0k3/GodMode9/releases)
- [sysUpdater](https://github.com/profi200/sysUpdater)

说明：系统更新包本身属于任天堂版权内容，这里不放下载链接，详见 [hShop](https://hshop.erista.me/) 。实际使用时必须严格匹配 `Old 3DS / JPN`。

# fuwari-blog

[c0d4.ink](https://c0d4.ink/) 的博客源码，基于 [Fuwari](https://github.com/saicaca/fuwari)、Astro 和 Svelte。

## 开发与写作

使用 Node.js 22 和 pnpm 9.14.4（与 `package.json`、CI 保持一致）。在项目根目录运行：

```sh
pnpm install --frozen-lockfile
pnpm dev
```

开发预览地址为 `http://localhost:4321`。

```sh
pnpm new-post my-post
```

新文章位于 `src/content/posts/`，使用 Markdown 编写；文章图片可与文章放在同一目录。常用文章属性：

```yaml
---
title: 文章标题
published: 2026-10-22
description: 文章摘要
image: ./cover.jpg
tags: [技术]
category: 笔记
draft: false
lang: ''
---
```

## 目录

| 路径 | 用途 |
| --- | --- |
| `src/content/` | 文章及独立页面内容 |
| `src/config.ts` | 站点、导航、个人资料等配置 |
| `src/data/` | 友链等数据 |
| `src/assets/`、`src/favicon/` | 需要构建处理的图片和图标 |
| `src/components/`、`src/layouts/`、`src/pages/` | 组件、布局和页面路由 |
| `src/styles/`、`src/plugins/`、`src/utils/`、`src/i18n/` | 主题样式、Markdown 扩展、工具及翻译 |
| `public/` | 直接复制到构建结果的静态资源 |
| `scripts/new-post.js` | `pnpm new-post` 使用的写作工具 |
| `.github/` | 构建检查、代码检查及依赖更新配置 |

根目录的 Astro、Svelte、Tailwind、PostCSS、TypeScript、Biome 和 Pagefind 配置供开发或构建工具使用；`pnpm-lock.yaml` 用于锁定依赖版本，均保留在仓库中。

## 构建与发布

```sh
pnpm build
pnpm preview
```

`pnpm build` 生成 `dist/`，包含页面、静态资源、RSS、站点地图及 Pagefind 搜索索引。**发布时只上传 `dist/` 的内容**，Nginx 的网站根目录指向这些静态文件。

`pnpm check` 可执行 Astro 检查；`pnpm format` 会修改源码格式。GitHub Actions 在推送和拉取请求时检查构建，不自动发布网站。

## 本地文件

部署、备份等个人维护脚本放在 `.local/`，由 Git 忽略。原 `scripts/deploy.ps1` 已移出版本控制，可在本地保留为 `.local/deploy.ps1`；这是可选的手动部署工具，博客构建不依赖它。

编辑器设置 `.vscode/`、Front Matter 扩展配置 `frontmatter.json`、本地环境文件 `.env*`、`node_modules/`、`.astro/` 和 `dist/` 均不提交。`.env.example` 可作为不含真实凭据的配置示例提交。

多语言模板说明及上游 Issue、PR、贡献模板已精简；主题使用说明可查阅 [Fuwari 上游文档](https://github.com/saicaca/fuwari)。

## 许可

保留上游作者 saicaca 的版权声明及 [MIT License](LICENSE)。

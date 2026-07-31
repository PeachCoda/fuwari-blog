---
title: "EasyUPX"
published: 2025-11-06T21:57:45+08:00
category: "CTF"
tags:
  - "wp"
  - "RE"
draft: false
lang: "zh_CN"
---
# EasyUPX

> <https://hgame.vidar.club/games/8/challenges?challenge=121>

<!-- more -->

<bh>

根据题目名称，

> upx -d main.exe

成功解包，拖入IDA, 先看看Strings

![EasyUPX-1](EasyUPX-1.png)

显然这是一个b64换表，获得字符表
再看看pseudocode
获得cipher

![EasyUPX-2](EasyUPX-2.png)

直接运行脚本

![EasyUPX-3](EasyUPX-3.png)

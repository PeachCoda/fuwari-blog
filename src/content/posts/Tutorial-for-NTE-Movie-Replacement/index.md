---
title: NTE Movie Replacement
published: 2026-05-02
description: 仅供交流学习使用
image: "./your_name.jpg"
category: 其他
tags: ["游戏", "mod"]
draft: false
---
声明：

方法是基于3dmigoto和dx11渲染的图层替换，所以并非直接替换视频文件，是具有相同效果的伪视频。

~~别问为什么不直接替换，问就是即使解包了也还有一层视频加密搞不定。~~

由于同样的原因，方法无法实现音频替换，视频里的是后期配音。

这些问题留给大佬们解决。orz

---

1. [云盘链接](https://pan.baidu.com/s/1PJlNiFKMbassuJYZ2_lfNA)下载工具包到本地，密码 `2333`。

2. 解压后打开文件夹，进入 `3dmigoto` ，用记事本编辑 `d3dx.ini`。
   
   按 `Ctrl+F` 输入 `make any changes` ，找到这一行下面的
   
   ```python
   target = D:\NTE\Neverness To Everness\Client\WindowsNoEditor\HT\Binaries\Win64\HTGame.exe
   ```

3. 打开异环游戏目录，依次进入
   
   > Neverness To Everness → Client → WindowsNoEditor → HT → Binaries → Win64
   
   找到 `HTGame.exe`，选中后右键选择复制文件地址。
   
   用复制的地址替换掉刚才 `d3dx.ini` 里找到的路径，**删去引号**，**保留等号左右的空格**。
   
   确保格式为
   
   > target = 你复制的地址
   
   保存 `d3dx.ini` 并退出。

4. 退回到 `replace_movie` 目录，将你想替换的视频（MP4格式）复制进该目录，重命名为 `input.mp4` 。（请展开文件扩展名，否则会变成 `input.mp4.mp4` ）
   
   双击 `launcher.bat` ，命令行会自动检测环境。
   
   > 如果提示缺少python环境，请自行前往python官网下载并配置环境。
   
   命令行提示“生成完成！”后，退出命令行，将新生成的 `Cinema` 文件夹放到 `3dmigoto\Mods` 。

5. 退回到 `3dmigoto` ， 双击运行该目录下的 `3DMigoto Loader.exe` ，授权管理员权限。
   
   运行异环启动器，点击左上角的齿轮图标，勾选游戏启动设置“游戏使用DX11”。
   
   点击开始游戏。
   
   > 注： `3DMigoto Loader.exe` 在开始游戏若干秒后会自动退出，这是正常的。

6. 控制角色进入电影院放映厅，按 F10 完成替换。

7. 如果想更改载入视频的帧率和画质，可以修改 `make_frame.py` 的参数区域（11~34行）
   
   > 注：
   > 
   > 因为该方法基于注入图形渲染，所以比较吃显存。
   > 
   > 总占用 ≈ 单张 DDS 大小 × 总帧数
   > 
   > 建议量力而行，显存低的话不要加载太多帧数。

完结撒花~

<bh>

**References:**

[3DMigoto-for-NTE by leDoctor](https://www.bilibili.com/video/BV1RYoGBqE8C/?share_source=copy_web&vd_source=7ba930e23e8552dc60459f63e42ad291)

[贴图替换思路 by 余晖森林](https://www.bilibili.com/video/BV1d8oyBfE6E/?share_source=copy_web&vd_source=7ba930e23e8552dc60459f63e42ad291)

<bh>

如有疑问请B站私信或在评论区留言

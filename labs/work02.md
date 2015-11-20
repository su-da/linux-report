# Linux 基本操作 (Week 02)

## 实验目地

 1. 了解 Linux 基本使用方法；
 2. 掌握 Linux 基本设置方式；
 3. 掌握 Linux 基本操作命令使用。
 
## 内容要求

1.  了解进程管理、文件管理与内存管理
2.  掌握系统设置文件与命令
3.  熟练使用系统操作与维护命令
4.  熟练使用系统操作与维护命令
 
## 实验原理

Linux 系统常用命令格式：\
`command [option] [argument1] [argument2] ...`\
其中 option 以“`-`”开始，多个 option 可用一个“`-`”连起来，如 `ls -l -a`
与 `ls -la` 的效果是一样的。根据命令的不同，参数分为可选的或必须的；所有
的命令从标准输入接受输入，输出结果显示在标准输出，而错误信息则显示在标准
错误输出设备。可使用重定向功能对这些设备进行重定向。如：\
`ls –lh > a.txt`\
命令在正常执行结果后返回一个 0 值，如果命令出错可未完全完成，则返回一个非零值(
在 shell 中可用变量 `$?` 查看)。 在 shell script 中可用此返回值作为控制逻辑的一
部分。

### DSL命令操作

**帮助命令**

> man 获取相关命令的帮助信息  
> 例如：man dir 可以获取关于 dir 的使用信息。
> 
> info 获取相关命令的详细使用方法  
> 例如：info info 可以获取如何使用 info 的详细信息。

**基本操作**

> echo 显示字符串
>
> pwd 显示当前工作目录
>
> ls 查看当前文件夹内容
>
> ls -a 查看当前文件夹内容（包括隐藏项）
>
> ls -l 查看当前文件夹内容（详细）
>
> ls / 查看根目录内容
>
> cd / 移动到根目录
>
> pwd 显示当前工作目录
>
> ls -al 查看根目录文件夹内容（详细情况并包括隐藏项）
>
> cd /home/dsl 回到“家”目录
>
> pwd 显示当前工作目录
>
> df -h 显示剩余磁盘空间，参数“-h”表示适合人读取 (human readable)
>
> du -h 显示文件夹（及子文件夹）所占空间
>
> mkdir fd0 在当前目录下创建目录 fd0 
>
> touch a.txt 创建一个空文件 a.txt
>
> `ls / -lh > a.txt` 利用重定向功能将根目录中的内容写入 a.txt。
>
> cat a.txt 显示 a.txt 内容
>
> wc a.txt 显示 a.txt 的行数，字数与字节数
>
> `find / -name *conf` 在根目录下（包括子目录）查找以 conf 结尾的文件
>
> sudo mount /dev/fd0 fd0 将软盘镜像挂载到目录 fd0 上
>
> cd fd0 进入软盘镜像所挂载的目录
>
> ls -lh 查看软盘镜像中的文件
>
> `cd ..` “`..`”表示进入上一层目录
>
> gzip a.txt 使用 gzip 压缩 a.txt
>
> ls -lh 查看当前文件夹
>
> sudo cp a.txt.gz fd0/ 将 a.txt 复制到 fd0 目录下，即将其复制到软盘镜像中
>
> `sudo mv fd0/a.txt.gz ./` 将 `a.txt` 移动到当前目录下，“`.`”表示当前目录
>
> sudo umount /dev/fd0 将软盘镜像卸载
>
> ls fd0 显示 fd0 目录内容
>
> gzip -d a.txt.gz 解压缩 a.txt.gz
>
> ls -lh 查看当前文件夹

**权限管理**

假设当前处于 /home/dsl 目录下，且有 a.txt (文件) 与 fd0 (目录)，当前用户名为 dsl。

> sudo cat /etc/passwd 用户
>
> sudo cat /etc/shadow 密码
>
> sudo cat /etc/group 组
>
> users 查看当前登录用户
>
> sudo chmod -x fd0 更改文件夹权限
>
> ls fd0 fd0 不能被执行，则意味着无法打开！
>
> sudo chmod +x fd0 更改文件夹权限
>
> ls fd0 fd0 能被打开
>
> sudo chown root fd0 更改目录 fd0 的所有者
>
> ls -lh 注意看 fd0 目录的属性
>
> `sudo chown dsl:root fd0` 更改目录 fd0 的所有者为 dsl,所属组为 root
>
> ls -lh 注意看 fd0 目录的属性
>
> chmod a-r a.txt 现在 a.txt 不具有“读”权限，不能被读取
>
> `cat a.txt #a.txt` 被设置为“不能被读取”，无法显示 a.txt 文件内容，显示相关提示！
>
> `chmod u+r a.txt` 现在 a.txt 文件所有有“读”权限
>
> cat a.txt 能看到a.txt 的内容了
 
## 实验步骤

1.  进入命令行
    开机默认工作在 fluxbox 桌面环镜下，为了能够输入命令须要采用下面两种
    方法之一。

2.  在 fluxbox 桌面上打开一个终端  
    这时单击桌面的 "ATerminal" 图标可以打开一个终端窗口，其背景为桌面背
    景。或者：
    * 在桌面空白处单击右键，选择：`XShells -> Light` 可打开一个白色背景的
      终端
    * 选择 `XShells -> Dark` 打开一个黑色背景终端

3.  关闭 DSL 图形窗口，使用图形界面
    * 同时按下“Ctrl”与“Alt”，不要松开，这时再按下 `Backspace`(退格)
      键，可以退出图形界面；
    * 或者右键单击桌面，选择：`WindowManager -> Exit` 退出图形界面。

4.  命令行提示符\
    打开终端窗口会看到如下提示符：  
    `dsl@box$`  
    进入字符界面会看到如下提示符：\
    `dsl@tty1[dsl]$`  
    前面的 dsl 表示当前用户名是 dsl，后面的 `$` 表示这是普通用户。若输入：\
    `sudo su`\
    sudo 表示以超级用户的身份执行后面的命令，su 表示暂时进入超级用户状态。
    这时会发现`$`变成了`#`，`#`表示超级用户（用户名一般为“root”），这时
    拥有最高的权限，通常仅用于系统设置、管理工作，不用它执行普通用户权限
    下也能完成的任务。输入：\
    `exit`\
    可退回到 dsl 用户状态。`#` 变回`$`

5.  用户管理  
    输入下面的命令可改变 dsl 用户的密码：  
    `sudo passwd dsl`  
    必须连续输入同样的密码两次确认。同理：  
    `sudo passwd root`  
    改变 root 用户的密码。更改完毕后可输入：  
    `su`  
    根据提示输入 root 用户的密码，即可进入超级用户状态。若要退出，则输入：  
    `exit`

6.  进程管理\
    查看进程，输入\
    `ps`
    注意，DSL 中使用的不是标准的 shell，而是 busybox，所以不接受任何参数，
    但是可以加 `--help` 显示帮助信息，如：\
    `ps --help`\
    会列出关于 "ps" 命令的介绍。

7.  中断进程  
    为了演示如何中断进程，首先运行一个持续时间比较长（不然尚未发送信号它
    自己就退出了）的程序，如：  
    `find / -name *f`  

    这个名令是在根目录 ("/") 下查找以 "f" 结尾的文件，并将结果列出。"`*`"
    为通配符，表示任意个数的任意字符。输入如下命令可看到 "find" 的帮助：  
    `find --help`  
    现在再次输入：  
    `find / -name *f`  
    然后按住"Ctrl"，再按"z"(这个操作记作：`Ctrl + z`)，即可将当前正在运
    行的程序切换到后台。现在输入：  
    `ps`  
    从列表中可以看类似下面的一行：  
    `679 dsl 536 T find / -name *f`  
    其中 679 是我进行实验时 "find" 的 PID 号，每一次实验都有可能不同。下
    面输入：  
    `kill 679`  
    这将向进程号为 679 的进程（即 "find" 进程）发送 TERM 信号，中止进程
    的运行。现在输入  
    `fg`  
    这条命令将刚才利用 "Ctrl" + "z" 切换到后台的进程切换到前台，如果命令
    "kill" 行成功，将显示：  
    `Terminated`  
    表示 "find" 进程中止运行。输入：  
    `ps`  
    查看是否属实。如果刚才没有输入 "kill" 命令，或进程号 (PID) 输入错误，
    则 "find" 进程会继续运行。另外，可使用 `Ctrl + c` 退出当前进程。

8.  文本编辑\
    输入：\
    `nano`\
    则进入文本编辑器 nano，在屏幕下方有两排菜单，前面的两个符号，如
    "`^X`"，表示使用这项菜单的快捷方式，"`^`" 表示按下"Ctrl"键，再按后面
    的字符，"`^X`"表示按下 "Ctrl" 再按 "x"，就执行 "Exit"(退出)。这个操
    作通常表示为：\
    `Ctrl + x`\
    现在随便输入一些内容。若要保存文件，输入：\
    `Ctrl + o`\
    注意是英文字母 (oh)，不是 0 (zero)，nano 会提示你输入文件名，输入文件
    名 a.txt，如果当前文件夹下的已经有了一个文件叫做 a.txt 则会提示你是
    否覆盖文件。输入 "y" 表示覆盖，输入 "n" 表示不覆盖，可重新取名。

9.  文件目录操作  
    要想删除文件 a.txt，输入：  
    `rm a.txt`  
    系统提示否删除，输入 "y" 表示是，"n" 表示否。  
    删除目录用：  
    `rmdir adir`  
    如果 adir 是一个空目录，则删除这个目录。  
    若要对文件改名，可利用移动文件的命令：  
    `mv a.txt b.txt`  
    将文件 a.txt 的名字改为 b.txt  
    目录改名也是如此：  
    `mv adir bdir`  
    则将 adir 改为 bdir  
    注意：新建目录可输入：  
    `mkdir adir`  
    新建一个目录，名字为 adir，（不可与已有目录重名）
 
## 结果与分析

1.  同一条命令加上不同参数有什么不同结果？

    _答：_ 输出结果有类同之处。\
    例如：`shutdown -h now` 立刻关机，其中 now 相当于时间为 0，`halt`，
    `poweroff` 也可以关机,或者直接 `init 0`\
    `shutdown -h 20:30` 系统将在今晚的8:30关机\
    `shutdown -h +10` 系统再过十分钟后自动关机\
    `shutdown -t3 -r now` 立刻重新开机，但在警告和删除processes这间，\
    `shutdown -k now 'Hey! Go away! now...'` 发出警告信息，但没有真的关
    机。\
    又如： \
    `top` 查看后台程序，监控系统性能\
    `top -d 2` 每两秒列新一次\
    `top -d -2 -p3690` 查看某个 PID\
    `top -b -n 2 >/tmp/top.txt` 将 top 的信息进行2次，然后将结果输出到 /tmp/top.txt
 
2.  linux 下命令参数前 `-` 和 `--` 有什么不同？  
    *答：* 等同的关系，  
    "`-`" 是简写  
    "`--`" 是全称
 
3.  linux 中,命令后加 `&` 与不加 `&` 的本质区别是什么?\

    _答：_ 加 `&` 是把命令交给 linux 内核去运行一个进程任务， 不加是通过
    shell 来启动一个进程任务。 linux 是一个多任务的操作系统，shell 可以
    理解为一个单任务的操作系统（就像 DOS 一样）。 单任务操作系统，可以通
    过自己启动另一个任务。 多任务操作系统，可以同时运行多个任务。
 
 
4.  DSL Linux 特点\
    DSL Linux 是集成了多种软件包的小型 Linux 发行版，从可引导 CD 或 USB
    驱动器上使用。使用方式如下：
    - 使用光盘引导系统
    - 从 USB 驱动器引导

    DSL 中的应用程序包括：
    - FluxBox 轻量级的快速窗口管理器
    - Firefox 浏览器
    - Dillo 浏览器
    - Links 基于文本的浏览器
    - Naim 多协议控制台即时消息工具，支持 AOL Instant Messenger（AIM）、AOL I Seek You（ICQ）、Internet Relay Chat（IRC）以及 The lily CMC。
    - Xpdf 开放源码的 Adobe Acrobat 查看器，用来显示 PDF（Portable Document Format）文件。
    - XMMS 用来播放 CD、MP3 和 MPEG 媒体文件（音乐和电影！）。
    - BashBurn，CD 刻录程序
    - Xpaint 彩色图像编辑工具，它具有大部分标准画图程序的特性，可以同时编辑多个图像文件。它可以支持诸如 PPM、XBM 和 TIFF 之类的格式。
    - VNCviewer/RDesktop 用来远程控制和管理其他 Windows 或 Linux 操作系统。
    - SSH/SCP、FTP、HTTPD、DHCP 客户机以及 NFS 等网络服务 
    - Sylpheed 基于 GTK+ 的 e-mail 客户机和新闻阅读器。
    - Vim（Vi）、Nano（Pico Clone）等文本编辑器。
 
5.  加上参数 "`--help`" 得到的信息有什么作用？

    *答：* 这是命令的原型程序里定义的就是解释命令处理的一种方法。
    一般来说，`--` 用于帮助，比如：`ls --help` 或 `ls --h`，`-` 用于命令的选项 
比如：`gcc -o tt tt.c` 中 `-o`。
 
6.  Linux 命令行中 `-r` 与 `-R` 有什么区别？哪些地方用大写，哪些地方用小写？

    _答：_ linux 命令行中 `-r` 与 `-R` 就是代表不同参数，根据需求用的参
    数不一样。只是刚好用了 r 这个字母，其实没有任何关联。看参数可以用 man 或
    者后面加 `--help`，具体用什么参数要根据事情决定。

7.  能否使用不同的方式实现同一个功能？

    _答：_ 可以。\
    例如：查看找文件 (find, grep, awk 更多的请参照 man page 或 shell 编
    程专题讲解)\
    几种介绍:\
    find 路径 -name 文件名\
    find /etc -name named.conf\
    locate 通过文件名搜索文件的工具 (要先通过 updatedb 建立索引数据库)\
    localte named.conf\
    whereis 是寻找二进制文件，同时也会找到其帮助文件\
    which 和 where 相似，只是我们所设置的环境变量中设置好的路径中寻找
 
## 本节是为了演示如何插入图片
 
最后是大家期待已久的爆照时间，如图 \ref{w02img01} 所示。

![我码实验报告很努力\label{w02img01}](media02/bricks-on-a-bike.jpg)

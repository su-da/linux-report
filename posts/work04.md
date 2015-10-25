# 小试 Ubuntu

日期：2015-09-28 00:57

网址：<http://www.jianshu.com/p/b59cc636468c>

---

首先介绍学习背景，学校开设了 linux 课程，为了利于上手就使用了带有图形界
面的 ubuntu 来进行教学。

再说明下个人背景，由于不堪忍受虚拟机运行的卡慢，又没 money 购置一台性能
X 炸天的电脑，只好考虑双系统了。厚着脸皮跑去问老师并且凭借自己半瓶水晃荡
的功夫，跟着网上的教程现学现卖。弄错了挺多次也重装了挺多次，过程挺复杂，
最终是成功了，双系统 Windows 10 + Ubuntu，默认启动 win10，高级启动里可以
选择 ubuntu。

其次再介绍下个人对 linux (ubuntu) 的看法。

linux 系统鼎鼎大名，很早就已听说过了。大到服务器，超级计算机，宇宙空间站，
小到 ATM，单片机，Android 手机甚至是遥控赛车，运行的都是 linux 系统或
者是根据 linux 内核延伸出来的系统。然而第一次听说 Ubuntu 系统还是在 2013
年，国内手机厂商魅族，发布运行 Ubuntu 系统的手机 mx4，从此 Ubuntu 系统才
渐渐映入我的脸帘。

先列出一条个人感觉在笔记本上异常实用的运行命令。

关闭触摸板：`sudo modprobe -r psmouse`

打开触摸板：`sudo modprobe psmouse`

说实用，起因就是在 ubuntu 下编辑文本或者输入命令的的时候，经常不小心碰到
触摸板（本来在 windows 下不灵的触摸板在 ubuntu 下异常灵敏），然后
LiberOffice Writer 或者终端像抽了风一样莫名其妙删了点什么或者写错行。室
友也有这个问题，顺便帮了他一把。

尝试了下reboot命令：

```
zhz@zhz-ThinkPad-Edge-E431:~$ reboot
reboot: 只有 root 能够执行
zhz@zhz-ThinkPad-Edge-E431:~$ su
密码：
root@zhz-ThinkPad-Edge-E431:/home/zhz# reboot
```

意想不到的是，竟然重启到win10了。。。。。

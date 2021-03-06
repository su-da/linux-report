程序概要设计
============

任务概述
--------

本设计是在 Google Android 平台上开发手机计步器软件，通过利用 Android SDK 模
拟器 [@androidsite] 来帮助软件的调试、运行，主要任务如下：

* 通过分析真机传感器的数据，能够提供较为精确的计步算法；
* 提供友好程序界面，并提供用户与手机交互信息的接口；
* 通过计步数据得出其他用户感兴趣的信息，如里程、速度、消耗热量等；
* 实现软件在 Android 智能手机上无 bug 运行，测试并记录数据。

系统用例图
----------

Google Android 计步器软件提供人机交互界面，通过用户输入数据 (或程序默认值)
来运行，其用例图如图 \ref{ch2usercase} 所示。

![计步器程序用例图\label{ch2usercase}](media/ch2usercase.pdf)

首先，用户打开程序界面，通过设置来保存自身数据。数据保存返回后，用户启动
计步程序，同时，将设置数据与计步数据联合可以计算出其他用户感兴趣的信息，
并在屏幕上显示出来。另外，用户可以通过退出菜单来结束程序。

用户操作流程
------------

用户操作流程图如图 \ref{ch2userflow} 所示。

![用户操作流程图\label{ch2userflow}](media/ch2userflow.pdf)

从操作流程图可以看出，程序提供用户设置窗口，用户输入自身参数 (可选，若用
户直接启动程序计数，则参数为默认值)，如体重、步长等，通过程序内部数据传
递得到用户参数。设置返回后程序启动计步功能，并将步数显示在屏幕上。另一方
面，通过程序获得手机系统时间，计算得出步速、里程、时速等信息。当用户结束
本次运动后计步结束，退出计步器程序。

程序内部数据流图
----------------

程序内部数据流图如图 \ref{ch2dataflow} 所示。

![程序内部数据流图\label{ch2dataflow}](media/ch2dataflow.pdf)

首先，程序读取手机内置传感器 (这里特指加速度计) 数值，经数据分析处理得到步
数。用户步长与步数计算可以直接得到里程；步数依据系统时间，经延时可以计算
出步速。热量消耗通过体重、时速可由公式得出。最终这些数据在屏幕上特定区域
显示，通过不断的数据更新来刷新屏幕。

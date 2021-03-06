结论
====

基于 Google Android 智能手机的软件的开发过程中借助 Android SDK (模拟器)
来编译源程序，在验证程序正确性过程中起到了很大的帮助作用。

计步器软件的设计完成了最初设定的目标：

-   提供友好程序界面，并提供用户与手机交互信息的接口；
-   通过计步数据得出其他用户感兴趣的信息，如里程、速度、消耗热量等；
-   实现软件在Android智能手机上无bug运行，测试并记录数据。
-   通过分析真机传感器的数据，能够提供较为精确的计步算法；

第 4 个目标的实现得益于传感器数据经仿真，使得计步精确地得到了很大的提高。
并且从理论与实际上验证了计步算法的精确性。该软件在 Android 手机上可以实
现无 Bug 运行，并提供了用户使用手册。

由于该计步器软件使用的是 Activity 来实现的，这就意味着程序不能后台运行。
因此今后的改进方向是将程序设计为 Service，以提高软件使用的方便性。

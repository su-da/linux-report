程序测试
========

权限设置
--------

一个应用程序可由多个 Activity 组成，其中至少有一个是主 Activity。当
Activity 在 AndroidManifest 文件的 \<Activity\> 标签中进行了声明时，应用
程序才有权限来启动相应的 Activity，其他的应用程序为了能够启动这个
Activity，需要在自己的 AndroidManifest 资源文件中的 \<uses-permission\>
元素中进行声明。

程序安装
--------

计步器程序调试完毕后即可以直接安装，安装文件 `*.apk` 在 `\bin` 目录下，
直接拷贝到 Android 手机安装即可。该软件测试是在 Android 2.1 平台上进行的。

测试结果
--------

以下是程序在 Google
Android2.1 平台手机上测试结果，见表 \ref{ch6table}，数据仅供参考。

在记录过程中，当运动速度较快时，记录的精确度比较可靠。而当运动较慢时 (如
散步) 时，有时运动却不计步，有时运动 1 步计为 2 步，存在较大的误差，如图
\ref{ch6slowtest} 所示。

![极慢速运动时加速度计模值图\label{ch6slowtest}](media/ch6slowtest.pdf)

这是因为当运动较慢时，加速度值非常小。通过观察，当慢速运动时，其波形犹如
随机噪声，运行 1 步的波形波峰不是很明显，甚至会出现好多波峰，这对步数检
测带来一定的困难。因此，该计步器程序用于慢速运动时还需要设计改变传感器灵
敏度。
\begin{longtable}[c]{c}
    \caption{计步器软件在 Google Android2.1 平台上运行结果}\\
    \nopagebreak \includegraphics{media/ch6table.pdf}
    \label{ch6table}
\end{longtable}

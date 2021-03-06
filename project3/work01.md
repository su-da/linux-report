# 绪论

## 项目的背景及意义

### 背景

随着国民经济的发展和社会的进步，多媒体技术和通信技术得到迅猛发展，医疗卫
生、安全监控等行业对视频的高清晰度和稳定性要求越来越高，在商场、街道、仓
库和小区等监控场所，以前D1、CIF等普通格式视频越来越不能满足人们的日常生
活需求 [@songhui2010]。而目前720P、1080P等高清视频采集与处理大部分由PC机
来实现，由于PC机处理速度快，内存大，可以完成视频采集、处理与传输等功能，
但是PC机也存在很多缺点，如功耗比较高且体积大，在应用方面受到限制。近年来
嵌入式系统得到迅猛发展，而且成本越来越低，性能越来越高，能够满足对体积、
可靠性、功能、成本、功耗等有严格要求的场合，且该系统一般都能够实现网络数
据传输，音视频编解码处理，多任务管理等功能。如今随着图像技术的快速发展，
出现了基于嵌入式具有图像处理功能的视频采集系统，但是市场上大部分嵌入式视
频应用系统还不具备高清视频采集与处理能力，其主要原因之一是以往的嵌入式处
理器达不到处理高清视频数据的能力，这个硬件上的技术瓶颈阻碍了医疗、监控等
行业嵌入式高清智能视频处理系统的发展^[@zhangxiuling2008]^。

本文在此背景下研究在嵌入式系统下实现从高清视频前端采集，视频图像处理，到
视频数据输出显示。

### 意义

目前市场上一般的嵌入式视频采集系统采集的视频分辨率都比较低，分辨率大小为
$352 \times 288$ 或 $704 \times 576$，即视频格式为CIF或D1。该视频对处理
器的处理速度要求不高，通常嵌入式处理器都能实时处理该视频数据。但是这种系
统也存在很多缺点，比如在安防监控领域，由于分辨率低即图像清晰度不高，一旦
出现特殊情况，在回放录像中就无法识别众多细节信息，如“面部特征”，“车牌号”
等，还有在医疗领域，如果视频图像不够清晰，那么就无法正确指导医师确诊病人
病情。在一些特殊的应用场合还需要对视频图像进行特殊处理，如在安防领域，可
能需要对在监测区域内的人脸进行实时跟踪，以便更好的保证该区域内的财产安全，
在医疗领域则可能需要对医学视频图像进行增强，边缘检测，黑白效果等方面的
视频处理，以便能尽快的从视频图片中观察出病因的所在 [@murakami2010]。本文
系统处理的视频信号为全高清数字信号，前端CMOS模块将采集的模拟信号进行A/D
变换后送到微处理器处理，由微处理器对采集的信号做硬件视频处理后由软件对视
频数据做图像算法处理，并对处理后的视频数据通过HDMI接口输出显示，同时设计
人机交互界面。该系统具有结构简单，操作方便，易于扩展等特点。

## 国内外研究现状

### 视频采集技术的发展现状与趋势

目前市场上主要有以下三种视频采集系统 [@litao2011; @tms320dm368manual]：

(1) 模拟信号视频采集

基于模拟信号的视频采集系统功能强大且价格较低，其技术发展至今已经相当成熟，
该系统主要有模拟设备组成，一般包括磁带录像机和模拟视频矩阵。现在有些场
合还在使用，但是由于网络技术的发展，需要远程控制或数据传输，而该系统无法
联网，且无法传输较长的距离，所以该设备已逐步被其他设备所取代。

(2) 基于PC机的视频采集系统

如今PC机的处理器处理能力越来越强，视频图像处理技术大大提高，人们开始利用
计算机进行数字视频采集与处理。由前端采集到视频数据通过视频图像采集卡传送
到本地计算机，再由计算机设备上的专门图像处理软件对采集的图像处理，还可以
通过网络，将该处理后的视频数据传送到远端计算机。该视频采集系统功能强大，
有丰富的图像处理软件，但是存在体积大、功耗高、可扩展性差等缺点。

(3) 基于嵌入式的视频采集系统

近年来无论在硬件或软件方面，嵌入式技术都得到快速发展，尤其是嵌入式操作系
统具有可裁剪移植、多任务、实时性、功耗低、体积小等方面优点，使嵌入式技术
成为如今研究的热点。嵌入式视频采集系统是将视频采集与该技术结合，该系统内
部有微处理器，将前端采集的视频数据处理后可以通过网络传送到远端输出显示或
者直接通过HDMI或VGA等接口直接输出显示。

嵌入式系统与前面两种系统相比，具有设备体积小、稳定性高、功耗低、可扩展性
强、维护费用低、无需专人看护、网络功能强大、网络资源利用率高、使用方便等
明显优势，正成为当前应用开发的热点。基于嵌入式的视频采集系统不仅具有上述
优点，而且采集的全数字视频信号便于存储及处理，比较符合当前视频采集技术的
发展趋势。因此，本文设计的系统便是基于嵌入式技术。

基于嵌入式技术及视频处理技术的发展，视频采集系统发展趋势如下：

(1) 小型化\
    为便于安装和携带方便，需要的嵌入式设备体积包括视频采集系统要尽可能的小巧。

(2) 大存储量\
    像在安防监控领域需要记录大量视频数据，需要更大的存储空间来存储视频信息。

(3) 高分辨率\
    如今手机、电视等屏幕分辩率不断提高，这就要求采集的视频图像分辩率也要
    不断提高。

(4) 高采样率\
    在医疗等领域需要记录瞬间发生的情况，就需要设备在很短时间内采样更多的
    帧数，这对处理器的处理能力也提出更高的要求。

(5) 网络化\
    为了将高速高清视频传送到远程接收设备，网络化必不可少，且对网络设备的
    性能也提出了更高的要求。

(6) 丰富的人机交互界面\
    为了用户使用方便，需要设计丰富的人机交互界面。

### 高清视频采集系统研究现状

高清视频采集系统是由一套完整的高清设备组成，包括图像采集、传输、存储、显
示等，每个部分均要达到高清标准，只要有一个环节达不到要求，系统技术指标就
达不到高清系统要求 [@lianggj2008]。高清可以分为三种格式：720P，1080i和
1080P，其中i代表隔行扫描，P代表逐行扫描，如果系统分辨率达到720P或1080i，
就称为高清系统，1080p则称为全高清系统 [@niuchao2012]。在监控领域，传统的
监控系统最高分辨率只能达到CIF或者D1格式，分辨率只有352×288和704×576大小。
而高的视频分辨率对视频采集设备也提出了很高的要求，一般系统前端至少需要
200万像素的摄像头 [@maoxiaodong2010]，本文系统采用500万像素摄像头。

目前市场上主要前端视频采集图像传感器一般采用CCD和CMOS两种。CCD传感器是电
荷耦合器，输出的是模拟信号，通过AD转换得到数字信号，CMOS传感器自身带有AD
转换，可以直接输出数字信号。在同等的低照度条件下CCD感光性较好，但随着
CMOS 集成电路工艺的不断进步和完善，CMOS传感器在很大方面已经能与CCD相媲美，
且价格低廉 [@wangqy1993; @mibenheye2006]。目前国内做高像素的图像传感器
这方面的研究还比较薄弱，专利技术还是被国外所掌握。

如今，我国的高清视频采集系统还是处于发展阶段，国内的供需比比较大，传统的
基于嵌入式的视频采集系统逐渐不能满足人们的需要，但是由于软硬件技术、成本
等方面限制，使得高清视频采集与处理系统的发展还需要一段时间。

## 项目主要内容

本文内容主要包括以下几个方面：

1.  分析系统实际应用需求，给出了基于DM3730高清视频采集与处理系统的总体设
    计框架以及系统主要芯片分析与选型。

2.  根据系统设计框架，设计系统硬件平台，包括原理图设计。硬件平台分为视频
    采集模块和处理器平台模块，而处理器平台模块包含处理器、电源、USB、
    DM900网卡、串口、ISP、MMC、HDMI等模块电路。

3.  搭建基于嵌入式Linux的系统软件开发平台，包括系统内核裁剪与移植、交叉
    编译环境搭建、u-boot的编译移植，文件系统制作，Samba和NFS服务器配置等。

4.  在搭建好的编译环境下，基于C语言设计系统软件。软件是按模块划分编程，
    包括视频驱动设计及配置，采集程序设计以及图像增强、边缘检测、人脸跟踪
    等视频处理算法实现。

5.  为了实现人机交互，利用QT设计用户界面，并实现界面的OSD (on screen
    display)功能。

## 结构安排

本文共分为7个章节，每个章节具体内容如下：

第 1 章  绪论部分，主要介绍课题研究背景及意义，视频采集的研究发展现状与趋
势，高清视频采集系统研究现状，以及内容和结构安排。

第 2 章  系统总体方案分析与设计，主要介绍系统需求分析及总体方案设计，然后
分别介绍硬件方案设计，包括硬件框架设计与主要芯片选型，最后介绍软件方案设
计，包括操作系统分析与选取和软件总体设计方案。

第 3 章  硬件平台设计，主要介绍硬件模块划分以及主要模块电路的设计过程。

第 4 章  嵌入式Linux软件开发平台搭建，主要介绍嵌入式Linux系统开发环境建立，
内核裁剪与移植，u-boot移植，文件系统制作，以及NFS，Samba服务器的配置等。

第 5 章  系统软件设计及算法实现，主要介绍视频采集驱动程序设计及参数配置，
视频采集应用程序设计以及视频处理方面的图像增强、边缘检测、人脸跟踪等算法
实现过程。

第 6 章  Qt/E界面设计及OSD功能实现，主要介绍Qt/E人机交互界面设计与实现以
及OSD功能实现。

第 7 章  结论与展望，对全文进行总结，并分析进一步需要完善的工作。

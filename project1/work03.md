详细设计
========

上一章主要从软件概要设计方面介绍了软件需要完成的基本功能以及用户的操作流
程。这一章从如何实现来详细说明软件的设计过程。计步器软件详细设计主要涉及
到程序界面设计以及程序代码的设计。

界面设计
--------

手机计步器软件要求提供友好界面，这就要求在界面的设计过程当中，不仅要完成
程序的基本功能，而且要以用户体验的原则，设计出符合用户需求的界面。这要从
界面的布局、颜色设置等方面予以考虑。

### 界面设计框架结构

程序设计中需提供人机交互界面，当用户在主界面状态下按下设置菜单时，界面需
跳转到设置窗口。其结构如图 \ref{ch3uistruct} 所示。

![界面结构框架示意图\label{ch3uistruct}](media/ch3uistruct.pdf)

其中，主界面是程序显示数据信息的窗口，包括步数、里程、速度、消耗热量等参
数。并提供从主界面切换到设置界面的菜单。设置界面包含用户输入 (体重、步长)
和选择 (性别、运动模式以及传感器灵敏度) 区域，并提供返回按钮。

### 界面布局设计

界面布局 (Layout) 为活动构造了用户界面的结构，布局包含了要展现给用户的所
有组件及各组件之间的结构，在 Google Android 设计中可以用以下两种方法来设计
布局：

1.  用可扩展标记语言 XML(Extensible Markup Language) 申明用户界面的组件—
    —相应于视图类及其子类，Android 提供了简单而明确的 XML 语法。
2.  在应用程序运行时来实例化布局——可以在应用程序中使用编程语句来创建视图
    和视图组件对象。

上述第一种方法可以实现大部分界面功能，如添加文本框 (TextView)、输入框
(EditView)、按钮 (Button) 等。而在实际设计中有些界面却也可以用上述第二种方
法，即编写代码的方式来实现，如完成动态效果、菜单等。以上这两种方法在计步
器程序界面的设计中均用到，以下逐一说明。

#### (一) XML设计布局 [@eoeandroid] {-}

用 XML 定义用户界面的好处是，它可以更好地把应用程序界面的展现部分和行为的
控制代码分隔开来。用户界面的描述对应用程序代码来说是外在的，因此，我们可
以很方便地修改界面而不需修改和重新编译代码。另外，在 XML 文件中定义布局，
使用户界面更形象化，更易于调试应用程序。

使用Android的XML语法 [@androiddevguide]，可以快速地设计用户界面的布局以
及其中包含的屏幕元素，每一个布局文件都要明确地包含一个根元素，这个根元素
必须是 View 或 ViewGroup 对象。我们可以用树状图来描述和定义一个活动的用户界
面，其结构图如图 \ref{ch3viewstruct} 所示。当定义好根元素后，就可以把额
外的布局对象或根组件作为元素的子元素 (如TextView、Button、EditView等) 添加
进来，这样，就逐渐创建了一个可以定义整个布局的视图层次结构。

![View 与 ViewGroup 结构图
\label{ch3viewstruct}](media/ch3viewstruct.pdf)

图 \ref{ch3viewstruct} 中，View 为视图，是 android.view.View 的一个实例
，它是一个存储有屏幕上特定的矩形内布局和内容属性的数据结构。视图负责处理
它所代表的屏幕布局、测量、绘制等。ViewGroup 为视图组，是
android.view.ViewGroup 的一个实例。它是一个特殊类型的视图，其功能是装载
和管理一组下层的视图和其他视图组，可以为界面增加结构，创建复杂界面元素。
应用上述方法创建如图 \ref{ch3mainuistruct} 为程序主界面结构示意图。

![主界面结构示意图\label{ch3mainuistruct}](media/ch3mainuistruct.pdf)

其中：

(1) 代表界面一个视图组 ViewGroup，负责装载其他视图(组)；
(2) 表示嵌于 (1) 内的两个 ViewGroup；
(3) 为文本显示区 TextView，包括区域 A、B、C、D、E，分别显示当前步数、里
    程、步速、时速、消耗热量。设计中可以通过设置相应的参数，以改变各区域
    的颜色：(1) 区位黑色背景，A、B、C、D、E 均设置成绿色。
(4) (图中虚线部分) 为菜单弹出区域，它的设计可以采用 (1)(2)(3) 的 XML 设
    计方法，也可以采用通过应用程序来实例化布局，在计步器程序的设计中使用
    了第二种方法，这在后面会进一步说明。

通过图 \ref{ch3mainuistruct} 可以看出，主界面追求一种简约风格，不仅满足
了程序的需求，而且也使得界面美观大方。

同样，设置界面结构示意图如图 \ref{ch3setuistruct} 所示，其中：

(1) 代表界面一个视图组 ViewGroup，负责装载其他视图(组)；
(2) 表示控件 Button，用于设置完毕后返回至主界面；
(3) 为 3 个视图组件，用于布局其内部视图。

![设置界面结构示意图\label{ch3setuistruct}](media/ch3setuistruct.pdf)

A1、A2 区域为文本提示框(固定不变)，A1 为 “请输入步长”，A2 为 “请输入体重”；

B1、B2 为用户编辑窗，分别对应于步长和体重的值；

C1、C2 为两个选择 (Spinner) 窗口，分别为运动模式选择和传感器灵敏度选择，
这里采用第二种布局方法，即通过程序来实例化布局来实现待选参数的设置。

从图 \ref{ch3setuistruct} 可以看出，设置界面与主界面一样，在追求简约的风
格的同时得到了程序运行所必须的数据，同时使界面看上去美观大方，符合了用户
和设计者的初衷。另外，在用户点击 C1、C2 的过程中还设计了动态效果 (见下文)，
大大减少了枯燥了程序界面。

#### (二) 程序实例化布局 {-}

-   Menu 菜单类

图 \ref{ch3mainuistruct} 中 (4) 中虚线部分为为当用户按下 Menu 键时弹出的，它用来管理菜单上的条目，这也是程序提供丰富功能的一条重要途径，同时对于编写友好界面有着举足轻重的作用。Menu 菜单实现的具体类图如图 \ref{ch3menuclass} 所示。

![Menu 菜单类类图\label{ch3menuclass}](media/ch3menuclass.pdf)

从图 \ref{ch3menuclass} 可以看到，Menu 类和 MenuItem 类均继承于 view 类，
view 类是一个视图类，用于实例化视图产生可视化界面。MenuItem 类与 Menu
类之间有着关联关系，Menuitem 中的 onOptionsItemSelectd () 方法需要找到
Menu 实例化后的名字，因此，必须在先实例化 Menu 后才能实例化 MenuItem。
Menu 菜单其具体实现步骤 [@Haseman2008] 如图 \ref{ch3menuprocessflow} 所示。

![Menu 实现结构框图
\label{ch3menuprocessflow}](media/ch3menuprocessflow.pdf)

从图 \ref{ch3menuprocessflow} 可以看出，当用户按下 Menu 时，程序才实例化
菜单，即首先调用父类函数来构建菜单视图，然后在菜单视图里添加相应的选项，
如帮助、设置、退出等，最后再返回一个值 (True)，这样完整的菜单就创建完成
了。

当菜单创建完毕，用户选择相应的菜单时便执行相应的功能。Menu 执行框图如图
\ref{ch3menuitemprocess} 所示。

![Menu 菜单执行框图
\label{ch3menuitemprocess}](media/ch3menuitemprocess.pdf)

-   动态效果的设置

Android 平台提供了两类动画：一类是 Tween [@DiMarzio2008] 动画，即通过对
场景里的对象不断做图像变换(平移、缩放、旋转)而产生动画效果；第二类是
Frane 动画，即顺序播放事先做好的图像。在上面的界面设计中使用到了第一类
Tween 中的 Animation 类来实现其动态效果。Animation 类关系如图
\ref{ch3animationclass} 所示，TranslateAnimation、RolateAnimation、
AlphaAnimation 等都是 Animation 的子类，分别实现了平移、旋转、和改变
Alpha等值动画。

![Animation类关系图
\label{ch3animationclass}](media/ch3animationclass.pdf)

图 \ref{ch3setuistruct} 中 C1、C2 选择的实现是以子类 TranslateAnimation
来实现，在实现过程中，为了方便，将动态效果的设置单独存放于
`res\anim\my_anim.xml` 文件下。这样做不仅使界面与代码适当分离，增强代码
的独立性，而且使它的实现相对简单，即只需导入 (loadAnimation) 即可。

代码设计
--------

计步器程序代码分为两部分，一部分为用户数据设置部分，另一部分为主程序 (在
Android 程序中也称为主程序)。这两部分之间的关系结构如图
\ref{ch3subrelation} 所示。

![主程序与设置程序关系图
\label{ch3subrelation}](media/ch3subrelation.pdf)

图中虚线部分为可选部分，即若用户设置信息则调用，不设置则按默认运行。主程
序与设置程序之间主要是完成数据的覆盖，用户数据与默认数据使用同一存储区。

### 设置程序

设置程序继承于 Activity 类。Activity 类是 Android 中最基本的一个类，有其
固定的生命周期。如图 \ref{ch3setclass} 所示为设置程序类关系图。

![设置程序类关系图\label{ch3setclass}](media/ch3setclass.pdf)

以上类 Button、TextView、Animation、EditText、Spinner 都是继承于 view 的
类。其中 Button 类用于实例化产生按钮，TextView 用于实例化产生文本显示区，
Animation 用于实例化产生动态效果，EditText 用于实例化产生文本编辑区，
Spinner 用于实例化产生单选按钮。Settings 类成员 `step_distance_setting`、
`body_weight_setting`、 `select_gender`、`select_move_mode`、
`select_sensitivity` 是用户设置的数据，这些数据将会覆盖程序默认数据。若
用户直接运行程序，则按默认数据来执行。并且，这些数据和主程序中声明的变量
共用同一个存储区域。

### 主程序

任何一个 Android 应用程序都会有一个主程序来负责整个程序的协调运作，同样，
在计步器软件中，主程序负责与设置程序交换 (覆盖) 数据、执行计步功能、程
序的启动与退出等。

主程序中由于涉及到传感器，因此必须使用接口 SensorListener 来使程序能够读
取传感器信息。另外，主程序可以设计为 Activity、也可以设计为 Service 的形
式，两者的区别在于前者不可以后台运行，后者可以后台运行。在这里我们为了方
便程序的调试，也将其设计为 Activity 的形式。

图 \ref{ch3pedoclass} 为主程序类关系图。主程序和设置程序有着相似之处，主
程序中也包含着类似图 \ref{ch3setclass} 中的结构，但没有完全画出来。由于
主程序是通过接口 SensorListener 得到，因此程序中必须含有
`onAccuracyChanged (int sensor, int accuracy)` 和 `onSensorChanged (int
sensor, float[] values)` 函数，分别用于当要求传感器精度改变时和当传感器
的数值发生变化时。这两个函数自动生成，程序员只需修改其内部实现代码即可。

![主程序类关系图\label{ch3pedoclass}](media/ch3pedoclass.pdf)

程序何时根据传感器数值计步，我们可以将其划分在 `onSensorChanged(int
sensor, float[] values)` 函数里。当传感器的数值随时间变化时，计步程序即
可检测到运动的步数。关于如何依据传感器数值计步将在第 5 章进行讨论，其他
数值信息都是依据步数计算出来，将在第 6 章进行讨论。

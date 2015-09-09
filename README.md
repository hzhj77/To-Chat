# To-Chat
开发环境现在为 Xcode Version 7.0 beta 5 (7A176x) ; iOS 7.0 + ;
cocoapods 版本： 0.37.0

在 iOS 9 下运行会出现界面问题，原因不明。

####下面介绍一下文件的大概目录先：
    .
    ├── To-Chat
    │   ├── StoryBoard：存放了所有的StoryBoard
    │   │   ├── Main.storyboard：      注册页面、登陆、引导页面
    │   │   ├── ToChatMain.storyboard：程序的主逻辑页面（TabBar）
    │   │   ├── Me.storyboard：       《我》页面的子页面
    │   │   ├── ToDo.storyboard：     《日程展示》页面的子页面
    │   │   └── Discover.storyboard： 《发现》页面的子页面
    │   ├── Models：数据类
    │   ├── Resources：资源文件
    │   ├── Util：一些常用控件和Category、Manager之类
    │   │   ├── Common：对原生控件的一些扩展
    │   │   ├── Manager：管理（工具）类
    │   │   └── OC_Category：对原生控件的一些扩展（和Common重复了……）
    │   ├── Vendor：用到的一些第三方类库，一般都有改动
    │   │   ├── FDFullscreenPopGesture：全屏丝滑返回
    │   │   ├── FDTemplateLayoutCell：动态计算 Cell 高度
    │   │   └── JTCalender：日历控件
    │   ├── ViewControllers：控制器，对应app中的各个页面
    │   │   ├── Main：对应 Main.storyboard 中的页面
    │   │   ├── Me：对应 Me.storyboard 中的页面
    │   │   ├── Discover：对应 Discover.storyboard 中的页面
    │   │   ├── ToChatMain：对应 ToChatMain.storyboard 中的页面 
    │   │   └── Todo：对应 Todo.storyboard 中的页面
    │   └── Views：视图类
    │       ├── UIMessageInputView：输入框（在多个页面用到）
    │       ├── Cell：所有的 UITableViewCell 都放在这里
    │       ├── CollectionCell：所有的 UICollectionViewCell 都放在这里
    │       └── XXX：其它视图
    └── Pods：项目使用了[CocoaPods](http://code4app.com/article/cocoapods-install-usage)这个类库管理工具
    
####冗余代码提示

由于使用了经历了三次新旧项目合并，所以对于头文件的维护没有跟上，导致了 JFMacros.h, SIUMacros.h, Step_it_up-Prefix.pch, APIUrl.h 中有大量冗余的宏定义，后期如果有宏定义请放在 JFMacros.h 中。

####CocoaPods里面用到的第三方类库（不全）

- SDWebImage:图片加载
- TTTAttributedLabel:富文本的label，可点击链接
- RegexKitLite:正则表达式
- hpple:html解析
- MBProgressHUD:hud提示框
- ODRefreshControl:下拉刷新
- TPKeyboardAvoiding:有文字输入时，能根据键盘是否弹出来调整自身显示内容的位置
- JDStatusBarNotification:状态栏提示框
- BlocksKit:block工具包。将很多需要用delegate实现的方法整合成了block的形式
- ReactiveCocoa:基于响应式编程思想的oc实践（是个好东西呢）
- Tips

####项目里面还有些需要注意的点

- 导航栏隐藏：在Info.plist中添加"UIViewControllerBasedStatusBarAppearance = false" 使得允许自定义Status Bar 的样式 和隐藏

- [leanCloud](https://leancloud.cn/) 现在使用了 leanCloud 的动态库（如果在 Podfile 需要使用 use_framework! 则需要使用他的[动态库](https://leancloud.cn/docs/start.html) ）
- UITableView：采用了[阳神](http://blog.sunnyxx.com)的[UITableView-FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)  项目 
[点击查看原理](http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/)

- Navigaiton： 采用了[阳神](http://blog.sunnyxx.com)的 [FDFullscreenPopGesture](https://github.com/forkingdog/FDFullscreenPopGesture) 
[点击查看原理](http://blog.sunnyxx.com/2015/06/07/fullscreen-pop-gesture/) 

- 整个项目准备依靠StoryBoard（原来全都是用代码写，后面发现一个动态渲染的机制很牛B）但是需要注意使用 Cocoapods 可能会导致错误，详情见[我的博客](http://blog.csdn.net/u010873087/article/details/48025197)



# To-Chat
开发环境现在为 Xcode 6.4 GM ; iOS 7.0 + ;
cocoapods 版本请使用 0.36.3 

下面介绍一下文件的大概目录先:

. ├── Coding_iOS │   ├── Models:数据类 │   ├── Views:视图类 │   ├── JFT0M:宏定义和Pch（用来导入有些全局需要的头文件）[Pch文件路径需要在项目设置中添加] │   ├── StoryBoard:放了Todo页面的故事版 │   │   ├── CCell:所有的CollectionViewCell都在这里 │   │   ├── Cell:所有的TableViewCell都在这里 │   │   └── XXX:ListView（项目、动态、任务、讨论、文档、代码）和InputView（用于聊天和评论的输入 框） │   ├── Controllers:控制器，对应app中的各个页面 │ │ ├── Discover:发现页面 │ │ ├── Reuse:在不同地方被调用的同一个页面的基类控制器 │   │   ├── Todo:日程页面 │   │   ├── Login:登录页面 │   │   ├── RootControllers:登录后的根页面 │   │   └── XXX:其它页面 │   ├── Images:Coding-iOS中用到的所有的图片都在这里 │   ├── Assets.xcassets:Step-it-up中的项目资源 │   ├── JFMacros.h:宏定义文件 │   ├── Resources:资源文件 │   ├── Util:一些常用控件和Category、Manager之类 │   │   ├── Common │   │   ├── Manager │   │   └── OC_Category（扩展） │   └── Vendor:用到的一些第三方类库[一般都有改动] │      ├── AFNetworking │  └──（其他） └── Pods:项目使用了CocoaPods这个类库管理工具

CocoaPods里面用到的第三方类库

SDWebImage:图片加载
TTTAttributedLabel:富文本的label，可点击链接
RegexKitLite:正则表达式
hpple:html解析
MBProgressHUD:hud提示框
ODRefreshControl:下拉刷新
TPKeyboardAvoiding:有文字输入时，能根据键盘是否弹出来调整自身显示内容的位置
JDStatusBarNotification:状态栏提示框
BlocksKit:block工具包。将很多需要用delegate实现的方法整合成了block的形式
ReactiveCocoa:基于响应式编程思想的oc实践（是个好东西呢）
Tips

[导航栏隐藏]在Info.plist中添加"UIViewControllerBasedStatusBarAppearance = false" 使得允许自定义Status Bar 的样式 和隐藏
[tabBar隐藏]在UIViewController+Swizzle中对ViewController的文件名进行判断，判断是否需要隐藏



leanCloud (https://leancloud.cn/)  对 cocoapod 高版本支持有问题

暂时使用了 leanCloud 的静态库（如果在 Podfile 需要使用 use_framework! 则需要使用他的动态库 https://leancloud.cn/docs/start.htm ）

UITableView 采用了阳神（http://blog.sunnyxx.com）的 UITableView-FDTemplateLayoutCell 项目 https://github.com/forkingdog/UITableView-FDTemplateLayoutCell
原理在 http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/

Navigaiton 采用了阳神的 FDFullscreenPopGesture 项目 https://github.com/forkingdog/FDFullscreenPopGesture
原理描述在http://blog.sunnyxx.com/2015/06/07/fullscreen-pop-gesture/

整个项目准备依靠StoryBoard（原来全都是用代码写，后面发现一个动态渲染的机制很牛B）
但是需要注意使用 Cocoapods 可能会导致错误，详情见我的博客 http://blog.csdn.net/u010873087/article/details/48025197


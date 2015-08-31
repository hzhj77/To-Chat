# To-Chat
开发环境现在为 Xcode 6.4 GM ; iOS 7.0 + ;
cocoapods 版本请使用 0.36.3 （ leanCloud (https://leancloud.cn/)  对 cocoapod 高版本支持有问题）
暂时使用了 leanCloud 的静态库（如果在 Podfile 需要使用 use_framework! 则需要使用他的动态库 https://leancloud.cn/docs/start.htm ）

项目中参考了大量的 Coding 客户端的代码 https://coding.net/u/coding/p/Coding-iOS/git

UITableView 采用了阳神（http://blog.sunnyxx.com）的 UITableView-FDTemplateLayoutCell 项目 https://github.com/forkingdog/UITableView-FDTemplateLayoutCell
原理在 http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/

Navigaiton 采用了阳神的 FDFullscreenPopGesture 项目 https://github.com/forkingdog/FDFullscreenPopGesture
原理描述在http://blog.sunnyxx.com/2015/06/07/fullscreen-pop-gesture/

整个项目准备依靠StoryBoard（原来全都是用代码写，后面发现一个动态渲染的机制很牛B）
但是需要注意使用 Cocoapods 可能会导致错误，详情见我的博客 http://blog.csdn.net/u010873087/article/details/48025197

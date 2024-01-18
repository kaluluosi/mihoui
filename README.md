# Mihoui

## 简介

这是在Godot上实现的类似Mihayo的栈式UI框架。在Godot上实现这个框架比我想象中简单太多了。

这个框架主要实现了以下：

1. 界面基类 —— `View`节点，用来取代Control节点，它能够更加规范的处理界面界面打开和关闭动画效果。
2. 栈式CanvasLayer ——`StackCanvasLayer`节点，它负责打开`View`和管理所有`View`的前后顺序。打开新的View会关闭隐藏之前的View，而当View销毁后，它会自动将上一个View推到栈顶然后还原。
3. 仿照mihoyo的做法，解决了循环导航的问题，也就是A-B两个界面互相跳转导致的死循环爆栈问题。
4. 通用的处理设备的导航按键，比如返回键行为。默认`View`会捕获`ui_cancel`然后关闭自己。
5. 更加内聚的生命周期管理，`UIMgr`只负责打开`View`，而`View`的销毁由`View`自己处理，`UIMgr`会监控`View`的出树事件来将上一个`View`推到栈顶，实现界面导航功能。
6. `View`内部维护一个内置的StackCanvasLayer —— `View`有一个`StackCanvasLayer`，这个`Layer`是用来弹出子界面用的。让界面自己去管理它打开的子界面，让子界面生命周期跟父界面一致。


## 示例体验

你可以clone这个项目然后直接运行，我已经制作了个假的星穹铁道来还原这个框架的效果。



https://github.com/kaluluosi/mihoui/assets/1620585/c7475ceb-c01b-4f37-8768-804cb79f8b67



![image](https://github.com/kaluluosi/mihoui/assets/1620585/34a44b7f-bcec-4d20-a292-cf8447e9cae9)

## 用法

1. 如果你只需要简单的使用，那么你可以直接用`StackCanvasLayer`节点制作一个场景来Autoload，命名为UIMgr，就像我的demo那样。
2. 用`View`节点作为根节点去制作你的界面。
3. 用`UIMgr.open`来打开你的界面。

由于代码比较简单具体我就不多说了。可以看示例。

## 这个框架还缺什么？

这个框架只能处理顶级界面和顶级界面内部的次级界面。没有对全局Hint系统提示，全局弹窗队列的支持，也没有覆盖层，这些需要你自己去实现或者等以后补充了。




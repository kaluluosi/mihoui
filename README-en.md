# Mihoui
## Introduction
This is a stack UI framework similar to Mihayo implemented on Godot. Implementing this framework on Godot was much simpler than I imagined.
This framework mainly implemented the following:
1. Interface base class - the "View" node is used to replace the Control node, which can handle the opening and closing animations of the interface in a more standardized manner.
2. Stack-style CanvasLayer - The "StackCanvasLayer" node is responsible for opening the "View" and managing all the "View" order. Opening a new View will close and hide the previous View, and when the View is destroyed, it will automatically push the previous View to the top of the stack and restore it.
3. Following the practice of Mihoyo, it solved the problem of cyclic navigation, that is, the stack overflow problem caused by the mutual jump between the A-B interface.
4. Generic handle device navigation keys, such as return key behavior. By default, View will capture ui_cancel and then close itself.
5. More cohesive lifecycle management, UIMgr is only responsible for opening View, while View's destruction is handled by View itself, UIMgr will monitor View's out tree event to push the previous View to the top of the stack and implement the interface navigation function.
6. View maintains an internal built-in StackCanvasLayer - View has a StackCanvasLayer, this Layer` is used to pop sub-interfaces. Let the interface manage the sub-interfaces it opens, let the sub-interfaces have the same life cycle as the parent interface.

## Sample Experience
You can clone this project and run it directly, I have made a fake Star Vault Road to restore the effect of this framework. 


https://github.com/kaluluosi/mihoui/assets/1620585/c7475ceb-c01b-4f37-8768-804cb79f8b67



![image](https://github.com/kaluluosi/mihoui/assets/1620585/34a44b7f-bcec-4d20-a292-cf8447e9cae9)

## Usage
1. If you just need to use it simply, then you can directly use theStackCanvasLayer node to make a scene and autoload it, named UIMgr, just like my demo.
2. Use the View node as the root node to make your interface.
3. Use UIMgr.open to open your interface.

The code is quite simple so I won't say much about it. You can see the sample.

## What is this framework lacking?
This framework can only handle top-level interfaces and secondary interfaces within the top-level interface. There is no support for global hint system prompts, global pop-up queues, and no overlap layer. You need to implement these yourself or wait for later additions.
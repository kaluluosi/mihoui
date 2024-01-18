extends CanvasLayer
class_name StackCanvasLayer
## 基于堆栈的layer[br]
## 还原米哈游的UI管理导航机制。
const StackControl = preload ("res://addons/mihoui/stack_control.gd")

var _stack: StackControl = StackControl.new()

func _ready():
	add_child(_stack)
	
func open(file_path: String, ui_data:={}):
	_stack.open(file_path, ui_data)
	
func clear():
	_stack.clear()

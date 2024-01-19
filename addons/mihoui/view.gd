extends Control
class_name View

const StackControl = preload ("res://addons/mihoui/stack_control.gd")

signal opened
signal closed

@export
var cached: bool = false

## 这是UI的额外数据[br]
## 比如我们希望打开某个UI直接跳到某个分页，选中某个东西，那么你就需要这种额外数据。
## 至于ui_data有什么属性，怎么在界面打开的时候处理这些属性，由开发者自己定义。
var ui_data: Dictionary:
	get: return get_meta("ui_data", {})

var _stack_contorl: StackControl = StackControl.new()

func _notification(what):
	match what:
		NOTIFICATION_ENTER_TREE:
			add_child(_stack_contorl, false, INTERNAL_MODE_BACK)
			await open()

## 使用界面内置的stack layer来管理打开子界面[br]
## 用来显示二级界面。
func open_subview(file_path: String, data:={}):
	_stack_contorl.open(file_path, data)

## 打卡界面[br]
func open():
	await process_show()
	opened.emit()
## 关闭界面[br]
## 默认free是true会直接销毁这个界面。
## XXX: 将隐藏和销毁都放到这个方法感觉总是有点混乱
func close(free: bool=true):
	await process_hide()
	closed.emit()
	if free:
		queue_free()

## 过程式hide，跟hide不同它会等待[_post_close]执行完才hide
func process_hide():
	await _post_close()
	hide()

## 过程式show，跟show不同他会等待[_post_show]执行完才show
func process_show():
	show()
	await _post_open()

## 用来处理打开的时候的动效[br]
## 想要执行动效就覆盖这个函数，记得要await动画。
func _post_open():
	pass
	
## 用来处理关闭时候的动效[br]
## 想要执行动效就覆盖这个函数，记得要await动画。
func _post_close():
	pass

## ui_cancel动作触发时的操作
## NOTE: 默认是释放这个节点，你可以重写这个函数拦截
func _on_ui_cancel():
	close(true)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_on_ui_cancel()

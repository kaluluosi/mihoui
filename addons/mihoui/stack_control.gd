extends Control
## 基于堆栈的layer[br]
## 还原米哈游的UI管理导航机制。

var resource_preloader: ResourcePreloader = ResourcePreloader.new()

## 界面历史记录，记录哪些界面文件打开过
var _views := {}

## 加个锁，防止界面还没打开完毕就因重复点击重复打开界面
var is_opening: bool

func _init():
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func _ready():
	child_exiting_tree.connect(_on_child_exiting)

func open(view_file: String, data:={}) -> View:
	if is_opening:
		return
	
	is_opening = true
	var view = _create_view(view_file, data)
	
	var top_view = _get_top()
	
	await _close_top()
	if view.get_parent():
		view.get_parent().remove_child(view)
	add_child(view)
	await _open_view(view)
	_print_stack()
	is_opening = false
	return view

func _on_child_exiting(node: Node):
	## 当由孩子离开，并且这个孩子是顶层孩子时处理。
	if get_child_count() > 1 and node == get_child( - 1):
		var previous = get_child( - 2) # 找出前一个界面
		# 有可能child exiting是因为游戏退出所致，判断一下
		if previous.is_inside_tree():
			await previous.open() # 重新打开前一个界面
			_print_stack()

func _open_view(view):
	if view.has_method("open"):
		await view.open()
	else:
		view.show()

func _close_view(view):
	if view.has_method("close"):
		await view.close()
	else:
		view.hide()

func _create_view(view_file: String, data:={}):
	# 如果_views里已经有记录了
	if view_file in _views:
		var view = _views[view_file]
		if is_instance_valid(view):
			# printt("堆栈中已经打开过，直接干掉它重新打开", view_file)
			remove_child(view)
		
		_views.erase(view_file)
	
	# printt("堆栈中没有打开过，重新实例化", view_file)
	var view_tscn
	if resource_preloader.has_resource(view_file):
		view_tscn = resource_preloader.get_resource(view_file)
	else:
		view_tscn = load(view_file)
			
	var view = view_tscn.instantiate() as View
		
	if view.cached and not resource_preloader.has_resource(view_file):
		# printt("ui mgr 缓存", view_file)
		resource_preloader.add_resource(view_file, view_tscn)
	view.set_meta("ui_data", data)
	_views[view_file] = view
	return view

func _get_top():
	if get_child_count() > 0:
		var view = get_child( - 1)
		return view

func _close_top():
	var view = _get_top()
	if view:
		await _close_view(view)

func _print_stack():
	var lines = PackedStringArray()
	
	for c in get_children():
		lines.append("{0}:{1}".format([c.name, c.get_meta("ui_data", {})]))
		
	printt("打印UI堆栈：", self, ">".join(lines))

func clear():
	for c in get_children():
		c.queue_free()

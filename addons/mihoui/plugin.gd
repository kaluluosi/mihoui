@tool
extends EditorPlugin

func _enter_tree():
	add_custom_type(
		"StackCanvasLayer",
		"CanvasLayer",
		preload ("res://addons/mihoui/stack_canvas_layer.gd"),
		preload ("res://addons/mihoui/stack_canvas_layer.svg")
	)
	add_custom_type(
		"View",
		"Control",
		preload ("res://addons/mihoui/view.gd"),
		preload ("res://addons/mihoui/view.svg")
	)

func _exit_tree():
	remove_custom_type("StackCanvasLayer")
	remove_custom_type("View")

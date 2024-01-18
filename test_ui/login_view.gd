extends "res://test_ui/base_view.gd"


# Called when the node enters the scene tree for the first time.
func _on_btn_enter_pressed():
	get_tree().change_scene_to_file("res://level/main.tscn")


func _on_ui_cancel():
	var dlg = AcceptDialog.new()
	dlg.title = "提示"
	dlg.dialog_text = "是否退出游戏"
	add_child(dlg)
	dlg.popup_centered()
	dlg.confirmed.connect(
		func():
			get_tree().quit()		
	)

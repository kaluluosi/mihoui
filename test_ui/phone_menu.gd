extends "res://test_ui/base_view.gd"




func _on_btn_enter_pressed():
	UIMgr.open("res://test_ui/compose_view.tscn")


func _on_btn_exit_pressed():
	var dlg = AcceptDialog.new()
	dlg.title ="提示"
	dlg.dialog_text = "是否返回标题"
	add_child(dlg)
	dlg.popup_centered()
	dlg.confirmed.connect(
		func():
			get_tree().change_scene_to_file("res://level/launcher.tscn")
			UIMgr.clear()
	)

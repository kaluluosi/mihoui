extends "res://test_ui/base_view.gd"



func _on_btn_enter_pressed():
	UIMgr.open("res://test_ui/phone_menu.tscn")



func _on_ui_cancel():
	UIMgr.open("res://test_ui/phone_menu.tscn")


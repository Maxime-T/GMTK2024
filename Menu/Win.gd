extends Control

func _on_leave_pressed():
	queue_free()
	

func _on_go_to_menu_pressed():
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

extends Control

func _enter_tree():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	
	modulate = Color(0,0,0,1)
	var t : Tween = get_tree().create_tween()
	t.tween_property(self, "modulate", Color(0.,0.,0.,1),0.3).set_ease(Tween.EASE_OUT)
	t.tween_property(self, "modulate", Color(1,1,1,1),0.8).set_ease(Tween.EASE_OUT)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels/Garden.tscn")


func _on_settings_button_pressed():
	var instance = Global.SettingsScene.instantiate()
	add_child(instance)


func _on_credit_button_pressed():
	get_tree().change_scene_to_file("res://Menu/credits.tscn")


func _on_exit_button_pressed():
	get_tree().quit()

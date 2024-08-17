extends Control

var SettingsScene : PackedScene = preload("res://Menu/settings.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Levels/Garden.tscn")


func _on_settings_button_pressed():
	var instance = SettingsScene.instantiate()
	add_child(instance)


func _on_credit_button_pressed():
	get_tree().change_scene_to_file("res://Menu/credits.tscn")


func _on_exit_button_pressed():
	get_tree().quit()

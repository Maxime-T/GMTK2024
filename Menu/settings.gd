extends Control

func _ready():
	$MarginContainer/VBoxContainer/HSlider.value = Global.slider_value
	$MarginContainer/VBoxContainer/Mute.button_pressed = Global.muted
	$MarginContainer/VBoxContainer/OptionButton.selected = Global.music_selected
	$MarginContainer/VBoxContainer/Fullscreen.button_pressed = Global.fullscreen
	if not Global.muted:
		AudioServer.set_bus_volume_db(0, Global.slider_value)

func _on_h_slider_value_changed(value):
	if not Global.muted:
		AudioServer.set_bus_volume_db(0, value)
	Global.slider_value = value


func _on_mute_toggled(toggled_on):
	Global.muted = toggled_on
	if toggled_on:
		AudioServer.set_bus_volume_db(0, -999)
	else:
		AudioServer.set_bus_volume_db(0, $MarginContainer/VBoxContainer/HSlider.value)


func _on_leave_pressed():
	queue_free()
	

func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		Global.fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		Global.fullscreen = false


func _on_option_button_item_selected(index):
	pass


func _on_go_to_menu_pressed():
	get_tree().change_scene_to_file("res://Menu/menu.tscn")

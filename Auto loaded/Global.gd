extends Node

var SettingsScene : PackedScene = preload("res://Menu/settings.tscn")

var slider_value = 10
var muted : bool = false
var music_selected = 0

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			#Le est c'est pour la deuxième node, cad le main (0 = la node Global)
			if get_tree().root.get_child(1).has_node("Settings"):
				get_tree().root.get_child(1).get_node("Settings").queue_free()
			else:
				get_tree().root.get_child(1).add_child(SettingsScene.instantiate())

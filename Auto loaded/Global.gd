extends Node

var SettingsScene : PackedScene = preload("res://Menu/settings.tscn")

var slider_value = 10
var muted : bool = false
var music_selected = 0

signal G_S_P_changed

var gold : float = 0:
	set(val):
		gold = snapped(val, 0.01)
		emit_signal("G_S_P_changed")

var sun : float = 0:
	set(val):
		sun = snapped(val, 0.1)
		emit_signal("G_S_P_changed")

var pollution : float = 0:
	set(val):
		pollution = snapped(val, 0.1)
		emit_signal("G_S_P_changed")

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			#Le est c'est pour la deuxième node, cad le main (0 = la node Global)
			if get_tree().root.get_child(1).has_node("Settings"):
				get_tree().root.get_child(1).get_node("Settings").queue_free()
			else:
				get_tree().root.get_child(1).add_child(SettingsScene.instantiate())

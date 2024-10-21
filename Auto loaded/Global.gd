extends Node

var SettingsScene : PackedScene = preload("res://Menu/settings.tscn")

var slider_value = 0
var muted : bool = false
var fullscreen : bool = true
var music_selected = 0

signal G_S_P_changed
signal CardPlayed

var gold : float = 9000000:
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
			if get_tree().root.get_child(1).has_node("SettingsLayer"):
				get_tree().root.get_child(1).get_node("SettingsLayer").queue_free()
				print("true")
			else:
				get_tree().root.get_child(1).add_child(SettingsScene.instantiate())

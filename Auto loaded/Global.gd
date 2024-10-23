extends Node

var DEBUG : bool = true

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

func check_targeted_groups_is_in_groups(targeted_groups : Array[String], groups) -> bool:
	var found_positive : bool = false
	var found_negative : bool = false
	var reverse_case : bool = false
	for target_group in targeted_groups:
		if target_group.begins_with("!"):
			reverse_case = true
			var actual_group = target_group.substr(1, target_group.length() - 1)
			if actual_group in groups:
				found_negative = true
		else:
			if target_group in groups:
				found_positive = true

	if found_negative:
		return false
	if found_positive or (reverse_case and !found_negative):
		return true
	return false

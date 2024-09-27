@tool
extends EditorPlugin

var plugin = preload("res://addons/StatsPlugin/Inspector.gd")

func _enter_tree() -> void:
	add_inspector_plugin(plugin)


func _exit_tree() -> void:
	remove_inspector_plugin(plugin)

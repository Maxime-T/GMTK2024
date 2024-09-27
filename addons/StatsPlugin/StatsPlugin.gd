@tool
extends EditorPlugin

var plugin = preload("res://addons/StatsPlugin/test.gd")

func _enter_tree() -> void:
	plugin = plugin.new()
	add_inspector_plugin(plugin)


func _exit_tree() -> void:
	remove_inspector_plugin(plugin)

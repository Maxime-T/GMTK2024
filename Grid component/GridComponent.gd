extends Node3D
class_name GridComponent

@export var component_name : String = ""
@export var meshInstance : MeshInstance3D

@export var stats : Stats

var gridPos : Vector2 = Vector2()
var plantGrid : PlantGrid

func get_adjacent_tile(v : Vector2) -> PlantGrid.Tile:
	return plantGrid.get_tile(gridPos.x+v.x, gridPos.y+v.y)

func get_highlight_zones() -> Array[Vector2]:
	return []

extends Node3D
class_name GridComponent

@export var component_name : String = ""
@export var meshInstance : MeshInstance3D

@export var stats : Stats

var gridPos : Vector2 = Vector2()
var plantGrid : PlantGrid

func get_highlight_zones() -> Array[Vector2]:
	return []

func get_adjacent_tile(v : Vector2) -> PlantGrid.Tile:
	return plantGrid.get_tile(gridPos.x+v.x, gridPos.y+v.y)

func get_adjacent_obstacle(vector : Vector2) -> Obstacle:
	var tile = get_adjacent_tile(vector)
	if tile != null and tile.grid_component != null and tile.grid_component is Obstacle:
		return tile.grid_component
	return null

func get_adjacent_plant(vector : Vector2) -> Plant:
	var tile = get_adjacent_tile(vector)
	if tile != null and tile.grid_component != null and tile.grid_component is Plant:
		return tile.grid_component
	return null

func get_adjacent_tools(vector : Vector2) -> Tools:
	var tile = get_adjacent_tile(vector)
	if tile != null and tile.grid_component != null and tile.grid_component is Tools:
		return tile.grid_component
	return null

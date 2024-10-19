extends Node3D
class_name GridComponent

var gridPos : Vector2 = Vector2()
var plantGrid : PlantGrid

func get_adjacent_tile(v : Vector2) -> PlantGrid.Tile:
	return plantGrid.get_tile(gridPos.x+v.x, gridPos.y+v.y)

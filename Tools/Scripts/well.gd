extends Tools
class_name Well

func get_highlight_zones() -> Array[Vector2]:
	var zoneArray : Array[Vector2]
	zoneArray.clear()
	for x in range(-2,3):
		for y in range(-2,3):
			if !(x==0 and y==0):
				zoneArray.append(Vector2(x,y))
	return zoneArray

func get_description():
	return "Provides +1 water in □ tiles."

func add_modifiers():
	for v in get_highlight_zones():
		var tile : PlantGrid.Tile = get_adjacent_tile(v)
		if tile != null:
			tile.add_modifier("water", targeted_groups, Modifier.new(self, Modifier.TYPE.FLAT, 1))
	
	do_water_update()
			


func _on_tree_exited() -> void:
	super()
	do_water_update()

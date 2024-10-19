extends Plant
class_name Carrot

func get_highlight_zones() -> Array[Vector2]:
	var zoneArray : Array[Vector2] = []
	zoneArray.clear()
	for x in range(-2,3):
		for y in range(-2,3):
			if !(x==0 and y==0):
				zoneArray.append(Vector2(x,y))
	return zoneArray

func get_description():
	return "Loses -25% score income per other carrots in □ ."

func update_self_modifier():
	var tile : PlantGrid.Tile = get_adjacent_tile(Vector2(0,0))
	tile.remove_all_modifier_from_source(self)
	tile.add_modifier("income", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, -0.25 * len(plant_list)))
	tile.add_modifier("score", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, -0.25 * len(plant_list)))

extends Plant
class_name Tomato

var zoneArray : Array[Vector2] = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]

func add_modifiers():
	for v in zoneArray:
		var tile : PlantGrid.Tile = get_adjacent_tile(v)
		if tile != null:
			tile.add_modifier("income", Modifier.new(self, Modifier.TYPE.MULT, 0.1))

func get_highlight_zones() -> Array[Vector2]:
	return zoneArray

func get_description():
	return "The □ plants scale up and earn you 10% more yields."

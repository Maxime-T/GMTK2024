extends Plant
class_name Corn

var zoneArray : Array[Vector2] = [Vector2(1,0), Vector2(2,0), Vector2(-1,0), Vector2(-2,0), Vector2(0,1), Vector2(0,2), Vector2(0,-1), Vector2(0,-2)]

func get_description():
	return "□ corns gains 10% grow rate."

func get_highlight_zones() -> Array[Vector2]:
	return zoneArray
	
func add_modifiers():
	for v in zoneArray:
		var tile : PlantGrid.Tile = get_adjacent_tile(v)
		if tile != null:
			tile.add_modifier("growSpeed", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, 0.1))

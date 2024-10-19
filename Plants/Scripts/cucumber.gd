extends Plant
class_name Cucumber

var zoneArray : Array[Vector2] = \
[Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1),
 Vector2(1,1), Vector2(-1,1), Vector2(1,-1), Vector2(-1,-1)]

func get_highlight_zones() -> Array[Vector2]:
	return zoneArray

func get_description():
	return "The □ plants gain 10% grow rate."

func add_modifiers():
	for v in zoneArray:
		var tile : PlantGrid.Tile = get_adjacent_tile(v)
		if tile != null:
			tile.add_modifier("growSpeed", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, 0.1))

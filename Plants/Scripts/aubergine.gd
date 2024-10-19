extends Plant
class_name Aubergine

var zoneArray : Array[Vector2] = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1), Vector2(1,1), Vector2(-1,1), Vector2(1,-1), Vector2(-1,-1)]

func get_description():
	return "Big income! But it takes time...
	Loses -10% grow rate per □ plants."

func get_highlight_zones() -> Array[Vector2]:
	return zoneArray

func update_self_modifier():
	var tile : PlantGrid.Tile = get_adjacent_tile(Vector2(0,0))
	tile.remove_all_modifier_from_source(self)
	tile.add_modifier("growSpeed", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, -0.1 * len(plant_list)))

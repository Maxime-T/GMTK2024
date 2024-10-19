extends Plant
class_name Wheat

var zoneArray : Array[Vector2] = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]

func get_description():
	return "Gains 50% Yield when all □ are other Wheat"

func get_highlight_zones() -> Array[Vector2]:
	return zoneArray

func update_self_modifier():
	var tile : PlantGrid.Tile = get_adjacent_tile(Vector2(0,0))
	tile.remove_all_modifier_from_source(self)
	
	if len(plant_list) == len(zoneArray):
		tile.add_modifier("income", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, 0.5))
		tile.add_modifier("score", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, 0.5))

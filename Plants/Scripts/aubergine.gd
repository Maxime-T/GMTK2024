extends Plant

var zoneArray : Array[Vector2] = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1), Vector2(1,1), Vector2(-1,1), Vector2(1,-1), Vector2(-1,-1)]

func get_description():
	return "Big income! But it takes time...
	Loses -10% grow rate per □ plants."

func get_highlight_zones() -> Array[Vector2]:
	return zoneArray

##
var tracked_groups : Array[String] = ["Plant"]
var targeted_groups : Array[String] = ["Aubergine"]

func add_modifiers():
	create_plant_list(tracked_groups)
	update_self_modifier()

func _on_plant_changed(new_plant, old_plant):
	update_plant_list(new_plant, old_plant, tracked_groups)
##

func update_self_modifier():
	var tile : PlantGrid.Tile = get_adjacent_tile(Vector2(0,0))
	tile.remove_all_modifier_from_source(self)
	print(plant_list)
	tile.add_modifier("score", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, -0.1 * len(plant_list)))

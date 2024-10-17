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

##
var tracked_groups : Array[String] = ["Carrot"]
var targeted_groups : Array[String] = ["Carrot"]

func add_modifiers():
	create_plant_list(tracked_groups)
	update_self_modifier()

func _on_plant_changed(new_plant, old_plant):
	update_plant_list(new_plant, old_plant, tracked_groups)
##

func update_self_modifier():
	var tile : PlantGrid.Tile = get_adjacent_tile(Vector2(0,0))
	tile.remove_all_modifier_from_source(self)
	tile.add_modifier("income", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, -0.25 * len(plant_list)))
	tile.add_modifier("score", targeted_groups, Modifier.new(self, Modifier.TYPE.MULT, -0.25 * len(plant_list)))


#func create_modifier_zones():
	#pass
#
#func delete_modifier_zones():
	#pass
#
#var alreadyCounted : Array[Plant]
#
#func _physics_process(delta):
	#super._physics_process(delta)
	#var rate = 0.
	#
	#for v in get_highlight_zones():
		#var x = pos.x + v.x
		#var y = pos.y + v.y
		#if (grid.is_inside(x, y)):
			#if grid.data[x][y] is Carrot && !alreadyCounted.has(grid.data[x][y]):
				#alreadyCounted.append(grid.data[x][y])
				#rate -= 0.25
		#
	#scoreRate += rate
#
#func get_highlight_zones() -> Array[Vector2]:
	#zoneArray.clear()
	#for x in range(-3,4):
		#for y in range(-3,4):
			#if !(x==0 and y==0):
				#zoneArray.append(Vector2(x,y))
				#
	#return zoneArray
#

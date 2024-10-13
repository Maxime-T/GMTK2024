extends Plant
class_name Carrot

func add_modifiers():
	for v in get_highlight_zones():
		var tile : PlantGrid.Tile = get_adjacent_tile(v)
		if tile != null:
			tile.add_modifier("income", ["Carrot"], Modifier.new(self, Modifier.TYPE.MULT, 1))

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

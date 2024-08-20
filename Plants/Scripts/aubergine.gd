extends Plant
#Time = 5mn -> donne un max de tune, peu de soleil
#Square -> 8 tiles

func get_description():
	return "Big income! But it takes time...
Loses -10% grow rate per □ plants."

var zoneArray : Array[Vector2] = \
[Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1),
 Vector2(1,1), Vector2(-1,1), Vector2(1,-1), Vector2(-1,-1)]


func create_modifier_zones():
	pass

var alreadyCounted : Array[Plant]

func _physics_process(delta):
	super._physics_process(delta)
	var rate = 0.
	
	for v in zoneArray:
		var x = pos.x + v.x
		var y = pos.y + v.y
		if (grid.is_inside(x, y)):
			if grid.data[x][y] is Plant && !alreadyCounted.has(grid.data[x][y]):
				alreadyCounted.append(grid.data[x][y])
				rate -= 0.1
		
	growRate += rate

func delete_modifier_zones():
	pass


func get_highlight_zones() -> Array[Vector2]:
	return zoneArray

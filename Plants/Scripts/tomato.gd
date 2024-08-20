extends Plant

var zoneArray : Array[Vector2] = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]


func create_modifier_zones():
	for v in zoneArray:
		if (grid.is_inside(pos.x + v.x, pos.y + v.y)):
			grid.groundData[pos.x+v.x][pos.y+v.y].incomeRate += .2


func delete_modifier_zones():
	for v in zoneArray:
		if (grid.is_inside(pos.x + v.x, pos.y + v.y)):
			grid.groundData[pos.x+v.x][pos.y+v.y].incomeRate -= .2


func get_highlight_zones() -> Array[Vector2]:
	return zoneArray

func get_description():
	return "The □ plants become bigger and earn you 10% more yields."

extends Plant
class_name Well

var zoneArray : Array[Vector2] 

func create_modifier_zones():
	for v in get_highlight_zones():
		if (grid.is_inside(pos.x + v.x, pos.y + v.y)):
			grid.groundData[pos.x+v.x][pos.y+v.y].water += 1


func delete_modifier_zones():
	for v in get_highlight_zones():
		if (grid.is_inside(pos.x + v.x, pos.y + v.y)):
			grid.groundData[pos.x+v.x][pos.y+v.y].water -= 1


func get_highlight_zones() -> Array[Vector2]:
	zoneArray.clear()
	for x in range(-2,3):
		for y in range(-2,3):
			if !(x==0 and y==0):
				zoneArray.append(Vector2(x,y))
	return zoneArray

func get_description():
	return "Provides +1 water in □ tiles."

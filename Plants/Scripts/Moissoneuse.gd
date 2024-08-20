extends Plant
class_name moissoneuse
var zoneArray : Array[Vector2]

func get_description():
	return "give +2 water in □ tiles."

func create_modifier_zones():
	pass

func delete_modifier_zones():
	pass

var alreadyCounted : Array[Plant]

func _physics_process(delta):
	super._physics_process(delta)
	rotation.y += delta/2.
	var rate = 0.
	
	for v in get_highlight_zones():
		var x = pos.x + v.x
		var y = pos.y + v.y
		if grid.data[x][y] is Plant && grid.data[x][y].isPlant:
			if grid.data[x][y].stages.size() - 1 == grid.data[x][y].stageIndex:
				grid.harvest_plant(grid.data[x][y])
		

func get_highlight_zones() -> Array[Vector2]:
	zoneArray.clear()
	for x in range(-2,3):
		for y in range(-2,3):
			if !(x==0 and y==0):
				zoneArray.append(Vector2(x,y))
				
	return zoneArray

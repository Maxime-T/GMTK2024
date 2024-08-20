extends Plant
class_name Corn
#Rare
#+ de 2 -> 8 tiles
func get_description():
	return "Gains 10% grow rate per □ corns."

var zoneArray : Array[Vector2] = [Vector2(1,0), Vector2(2,0), Vector2(-1,0), Vector2(-2,0), Vector2(0,1), Vector2(0,2), Vector2(0,-1), Vector2(0,-2)]


func create_modifier_zones():
	pass


func delete_modifier_zones():
	pass

var alreadyCounted : Array[Plant]

func _physics_process(delta):
	super._physics_process(delta)
	var rate = 0.
	
	for v in zoneArray:
		var x = pos.x + v.x
		var y = pos.y + v.y
		if (grid.is_inside(x, y)):
			if grid.data[x][y] is Corn && !alreadyCounted.has(grid.data[x][y]):
				alreadyCounted.append(grid.data[x][y])
				rate += 0.1
		
	growRate += rate

func get_highlight_zones() -> Array[Vector2]:
	return zoneArray

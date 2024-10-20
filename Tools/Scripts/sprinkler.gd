extends Tools
class_name Sprinkler

#var zoneArray : Array[Vector2] 
#
#func get_description():
	#return "Provides +2 water for □ tiles."
	#
	#
#func create_modifier_zones():
	#for v in get_highlight_zones():
		#if (grid.is_inside(pos.x + v.x, pos.y + v.y)):
			#grid.groundData[pos.x+v.x][pos.y+v.y].water += 2
#
#
#func delete_modifier_zones():
	#for v in get_highlight_zones():
		#if (grid.is_inside(pos.x + v.x, pos.y + v.y)):
			#grid.groundData[pos.x+v.x][pos.y+v.y].water -= 2
#
#
#func get_highlight_zones() -> Array[Vector2]:
	#zoneArray.clear()
	#for x in range(-2,3):
		#for y in range(-2,3):
			#if !(x==0 and y==0):
				#zoneArray.append(Vector2(x,y))
	#
	#zoneArray.append(Vector2(0,3))
	#zoneArray.append(Vector2(0,-3))
	#zoneArray.append(Vector2(1,3))
	#zoneArray.append(Vector2(1,-3))
	#zoneArray.append(Vector2(-1,3))
	#zoneArray.append(Vector2(-1,-3))
	#
	#zoneArray.append(Vector2(3,0))
	#zoneArray.append(Vector2(-3,0))
	#zoneArray.append(Vector2(3,1))
	#zoneArray.append(Vector2(-3,1))
	#zoneArray.append(Vector2(3,-1))
	#zoneArray.append(Vector2(-3,-1))
	#
	#return zoneArray

extends Plant
#Square (8 tiles)
#func get_description():
	#return "The □ plants gain 5% grow rate."
#
#var zoneArray : Array[Vector2] = \
#[Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1),
 #Vector2(1,1), Vector2(-1,1), Vector2(1,-1), Vector2(-1,-1)]
#
#func create_modifier_zones():
	#for v in zoneArray:
		#if (grid.is_inside(pos.x + v.x, pos.y + v.y)):
			#grid.groundData[pos.x+v.x][pos.y+v.y].growRate += .05
#
#
#func delete_modifier_zones():
	#for v in zoneArray:
		#if (grid.is_inside(pos.x + v.x, pos.y + v.y)):
			#grid.groundData[pos.x+v.x][pos.y+v.y].growRate -= .05
#
#
#func get_highlight_zones() -> Array[Vector2]:
	#return zoneArray

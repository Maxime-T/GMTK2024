extends Plant
class_name Wheat

#func get_description():
	#return "Gains 40% Yield when all □ are other Wheat"
#
#var zoneArray : Array[Vector2] = [Vector2(1,0), Vector2(-1,0), Vector2(0,1), Vector2(0,-1)]
#
#
#func create_modifier_zones():
	#pass
#
#
#func delete_modifier_zones():
	#pass
#
#var alreadyCounted : Array[Plant]
#var buffActivated : bool = false
#
#func _physics_process(delta):
	#super._physics_process(delta)
	#var rate = 0.
	#
	#alreadyCounted.clear()
	#
	#for v in zoneArray:
		#var x = pos.x + v.x
		#var y = pos.y + v.y
		#if (grid.is_inside(x, y)):
			#if grid.data[x][y]:
				#alreadyCounted.append(grid.data[x][y])
	#
	#if alreadyCounted.size() >= 4 and buffActivated == false:
		#scoreRate += 0.4
		#incomeRate += 0.4
		#buffActivated = true
	#
	#if alreadyCounted.size() < 4 and buffActivated == true:
		#scoreRate -= 0.4
		#incomeRate -= 0.4
		#buffActivated = false
#
#func get_highlight_zones() -> Array[Vector2]:
	#return zoneArray

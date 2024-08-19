extends Plant

func create_modifier_zones():
	if grid.is_inside(pos.x+1, pos.y):
		grid.groundData[pos.x+1][pos.y].incomeRate += 10.
		
	if grid.is_inside(pos.x-1, pos.y):
		grid.groundData[pos.x-1][pos.y].incomeRate += 10.
		
	if grid.is_inside(pos.x, pos.y+1):
		grid.groundData[pos.x][pos.y+1].incomeRate += 10.
		
	if grid.is_inside(pos.x, pos.y-1):
		grid.groundData[pos.x][pos.y-1].incomeRate += 10.

func delete_modifier_zones():
	pass

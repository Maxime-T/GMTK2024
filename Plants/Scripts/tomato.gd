extends Plant

func create_modifier_zones():
	pass
	#grid.data[pos.x+1][pos.y].incomeRate += 10.
	#grid.data[pos.x-1][pos.y].incomeRate += 10.
	#grid.data[pos.x][pos.y+1].incomeRate += 10.
	#grid.data[pos.x][pos.y-1].incomeRate += 10.

func delete_modifier_zones():
	push_warning("tried to call default function")

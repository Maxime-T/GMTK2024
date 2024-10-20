extends GridComponent
class_name Tools

func get_adjacent_tools(vector : Vector2) -> Tools:
	var tile = get_adjacent_tile(vector)
	if tile != null and tile.grid_component != null and tile.grid_component is Tools:
		return tile.grid_component
	return null

extends Ground
class_name Mycelium

func add_modifiers():
	var tile = get_adjacent_tile(Vector2(0,0))
	tile.add_modifier("score", ["Mushroom"], Modifier.new(self, Modifier.TYPE.MULT, 0.25))
	tile.add_modifier("growSpeed", ["!Mushroom"], Modifier.new(self, Modifier.TYPE.REAL_MULT, 0))

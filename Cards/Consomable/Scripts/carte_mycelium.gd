extends Consomable

@export var Mycelium : PackedScene

func consomable_general_effect(x,y):
	PlantGridNode.create_ground(x, y, Mycelium, true)
	var tile : PlantGrid.Tile = PlantGridNode.get_tile(x,y)
	var new_ground = PlantGridNode.get_ground(x,y)
	tile.add_modifier("score", ["Mushroom"], Modifier.new(new_ground, Modifier.TYPE.MULT, 0.25))
	tile.add_modifier("growSpeed", ["!Mushroom"], Modifier.new(new_ground, Modifier.TYPE.MULT, -9999))
	return true
	

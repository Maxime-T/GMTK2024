extends Consomable

@export var Mycelium : PackedScene

func consomable_general_effect(x,y) -> bool:
	if PlantGridNode.get_ground(x,y) is not Mycelium:
		PlantGridNode.create_ground(x, y, Mycelium, true)
		return true
	return false
	

extends Consomable

@export var Ground : PackedScene

func consomable_general_effect(x,y):
	PlantGridNode.create_ground(x, y, Ground, true)
	

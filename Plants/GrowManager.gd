extends Node
class_name GrowManager

var growStages : Array[GrowStage]
var totalGrowTime : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is GrowStage:
			growStages.append(child)
			totalGrowTime += child.time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends Node
class_name GrowManager

var growStages : Array[GrowStage]
var totalGrowTime : float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	totalGrowTime = calculate_grow_time()


func calculate_grow_time():
	var totalTime = 0
	for child in get_children():
		if child is GrowStage:
			growStages.append(child)
			totalTime += child.time
	return totalTime

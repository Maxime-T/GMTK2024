extends Node
class_name GrowManager

signal stage_changed(newStage : GrowStage)
signal fully_grown

var growStages : Array[GrowStage]
var index : int = 0

var time : float = 0

var totalGrowTime : float = 0

var growPourcent : float :
	set(v):
		growPourcent = clamp(v, 0, 1)

var growSpeed : float = 1. :
	set(v):
		growSpeed = max(v, 0)

func _ready():
	update_grow_stage()
	totalGrowTime = calculate_grow_time()
	

func _physics_process(delta):
	grow(delta)

func update_grow_stage() -> void:
	for child in get_children():
		if child is GrowStage:
			growStages.append(child)

func grow(delta):
	time += delta * growSpeed
	growPourcent = calculate_total_elapsed_time() / totalGrowTime
	
	if time > growStages[index].time:
		if index < growStages.size() - 1:
			index = index + 1
			emit_signal("stage_changed", growStages[index])
			time = 0
		else:
			emit_signal("fully_grown")

func calculate_total_elapsed_time():
	var totalTime = 0
	for i in range(index):
		totalTime += get_child(i).time
	return totalTime + time

func calculate_grow_time():
	var totalTime = 0
	for child in get_children():
		if child is GrowStage:
			totalTime += child.time
	return totalTime

func reset():
	time = 0
	index = 0
	emit_signal("stage_changed", growStages[0])

extends Node3D
class_name Plant

@export_category("Setup")
@export var meshInstance : MeshInstance3D
@export var growManager : GrowManager
@export var anim : AnimationPlayer
var grid : PlantGrid

@export_category("Plant Info")
@export_group("General")
@export var plantName : String
@export var isPlant : bool = true

@export_group("Costs")
@export var GoldCost : int = 0

@export var waterNeeded : int = 0
@export var pollutionGeneration : float = 0

@export_group("Production")
@export var income : float = 0
@export var sunProd : float = 0

var growRate : float = 1 :
	set(value):
		value = clamp(value, 0,1)
		#growManager.totalGrowTime /= value
		if isPlant:
			if value > growRate:
				growTimer.start(calculate_total_time(stage.time, value, waterGrowSpeedRatio))
		
		growRate = value

var incomeRate : float = 1
var scoreRate : float = 1:
	set(value):
		value = max(value, 0)
		scoreRate = value

var water : int = 0:
	set(value):
		value = max(value, 0)
		if isPlant:
			if (value < waterNeeded):
				if value == 0:
					noWaterNode.visible = true
					warningWaterNode.visible = false
				else:
					noWaterNode.visible = false
					warningWaterNode.visible = true
				
			else:
				noWaterNode.visible = false
				warningWaterNode.visible = false
			
			if waterNeeded != 0:
				waterGrowSpeedRatio = float(value) / float(waterNeeded)
			else:
				waterGrowSpeedRatio = 1.
			#growManager.totalGrowTime /= waterGrowSpeedRatio
			growTimer.start(calculate_total_time(stage.time, growRate, waterGrowSpeedRatio))
		water = value

var waterGrowSpeedRatio : float = 1.

var pos : Vector2

var stage : GrowStage
var stages : Array[GrowStage]
var stageIndex : int = 0
var growTimer : Timer

var noWaterNode : Sprite3D
var warningWaterNode : Sprite3D

func _ready():
	
	warningWaterNode = load("res://Plants/warning_water_logo.tscn").instantiate()
	warningWaterNode.visible = false
	add_child(warningWaterNode)
	
	noWaterNode = load("res://Plants/no_water_logo.tscn").instantiate()
	noWaterNode.visible = false
	add_child(noWaterNode)
	
	create_modifier_zones()
	rotation.y = randf_range(0, 2*PI)
	
	if isPlant:
		
		stages = growManager.growStages
		stage = stages[stageIndex]
		
		growTimer = Timer.new()
		growTimer.one_shot = true
		growTimer.connect("timeout", timer_end)
		add_child(growTimer)
	
	next_stage()

func next_stage():
	if (stageIndex < stages.size()):
		anim.play("startStage")
		stage = stages[stageIndex]
		meshInstance.mesh = stage.mesh
		
		growTimer.start( calculate_total_time(stage.time, growRate, waterGrowSpeedRatio) )
		
		stageIndex += 1

func reset_growth():
	stageIndex = 0
	lifetime = 0
	next_stage()

func timer_end():
	if (stageIndex < stages.size()):
		anim.play("endStage")
		if !anim.is_connected("animation_finished", animation_finished):
			anim.connect("animation_finished", animation_finished)

func animation_finished(animation : StringName):
	if animation == "endStage":
		next_stage()

var lifetime : float
@export var animationScale : float = 0.

func _physics_process(delta):
	if isPlant:
		lifetime += delta * waterGrowSpeedRatio * growRate
		var timeRatio = clamp( lifetime / growManager.totalGrowTime + 0.4, 0.4, 1.)
		
		scale = (Vector3(1, 1, 1) * timeRatio * animationScale * clamp(incomeRate,0,2) * clamp(scoreRate,0,2) ).clamp(Vector3(0,0,0), Vector3(3,3,3))

func calculate_total_time(baseTime : float, growRate, waterGrowSpeedRatio):
	if growRate == 0 or waterGrowSpeedRatio == 0:
		return 9999999999
	return stage.time / (growRate * waterGrowSpeedRatio)

func _exit_tree():
	delete_modifier_zones()


#DEFAULTS ######################################################


func create_modifier_zones():
	push_warning("tried to call default function")

func delete_modifier_zones():
	push_warning("tried to call default function")

func get_highlight_zones() -> Array[Vector2]:
	push_warning("tried to call default function")
	return []






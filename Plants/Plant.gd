extends Node3D
class_name Plant

@export_category("Setup")
@export var meshInstance : MeshInstance3D
@export var growManager : GrowManager

@export_category("Plant Info")
@export_group("General")
@export var plantName : String

@export_group("Costs")
@export var sunCost : int = 0:
	set(val):
		Global.sun += sunCost - val
		sunCost = val

@export var waterCost : int = 0
@export var pollutionGeneration : float = 0

@export_group("Production")
@export var goldValue : float = 0
@export var timeToGrow : float = 60 #en seconde
@export var growRate : float = 1

var pos : Vector2

var stage : GrowStage
var stages : Array[GrowStage]
var stageIndex : int = 0
var growTimer : Timer
var scaleFactor : float = 1:
	set(val):
		scale = Vector3(val, val, val)
		scaleFactor = val

var lifetime : float

func _ready():
	stages = growManager.growStages
	stage = stages[stageIndex]
	
	growTimer = Timer.new()
	growTimer.one_shot = true
	growTimer.connect("timeout", next_stage)
	add_child(growTimer)
	
	next_stage()

func next_stage():
	if (stageIndex < stages.size()):
		stage = stages[stageIndex]
		meshInstance.mesh = stage.mesh
		
		growTimer.start(stage.time)
		
		stageIndex += 1

func _physics_process(delta):
	lifetime += delta
	var timeRatio = clamp( lifetime / growManager.totalGrowTime + 0.2, 0., 1.)
	scale = Vector3(timeRatio, timeRatio, timeRatio)













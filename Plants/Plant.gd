extends Node3D
class_name Plant

@export_category("Setup")
@export var meshInstance : MeshInstance3D
@export var growManager : GrowManager
@export var anim : AnimationPlayer

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

func _ready():
	rotation.y = randf_range(0,2*PI)
	
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
		
		growTimer.start(stage.time)
		
		stageIndex += 1

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
	lifetime += delta
	var timeRatio = clamp( lifetime / growManager.totalGrowTime + 0.2, 0., 1.)
	
	scale = Vector3(timeRatio, timeRatio, timeRatio) * animationScale













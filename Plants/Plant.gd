extends Node3D
class_name Plant

@export_category("Setup")
@export var growManager : GrowManager
@export var meshInstance : MeshInstance3D

@export_category("Plant Data")
@export var plantName : String
@export var isPlant : bool = true

@export_group("Costs")
@export var GoldCost : int = 0
@export var waterNeeded : int = 0
@export var pollutionGeneration : float = 0

@export_group("Production")
@export var income : float = 0
@export var sunProd : float = 0

var gridPos : Vector2 = Vector2()
var water : int = 0
var growSpeed : float = 1. :
	set(v):
		growManager.growSpeed = v
		growSpeed = growManager.growSpeed
var animationScale : float = 1.
var harvestable : bool = false

func _ready():
	play_aparition_animation()
	meshInstance.mesh = growManager.growStages[0].mesh
	
	#Conect Signals
	growManager.stage_changed.connect(on_stage_changed)
	growManager.fully_grown.connect(on_fully_grown)
	

func _physics_process(delta):
	scale = Vector3.ONE * animationScale * (growManager.growPourcent+0.2 / (1+0.2))

func on_stage_changed(newStage : GrowStage):
	var t = create_tween()
	t.tween_property(self, "animationScale", 0.3, 0.1)
	t.tween_callback(meshInstance.set_mesh.bind(newStage.mesh))
	t.tween_property(self, "animationScale", 1.0, 0.1)

func on_fully_grown():
	harvestable = true
	meshInstance.get_material_overlay().set_shader_parameter("enabled",true)

func play_aparition_animation() -> void:
	animationScale = 0
	var t = create_tween()
	t.tween_property(self, "animationScale", 1., 0.1)
	
#@export_category("Plant Info")
#@export_group("General")
#@export var plantName : String
#@export var isPlant : bool = true
#
#@export_group("Costs")
#@export var GoldCost : int = 0
#
#@export var waterNeeded : int = 0
#@export var pollutionGeneration : float = 0
#
#@export_group("Production")
#@export var income : float = 0
#@export var sunProd : float = 0
#
#var growRate : float = 1 :
	#set(value):
		#value = clamp(value, 0,1)
		##growManager.totalGrowTime /= value
		#if isPlant:
			#if value > growRate:
				#growTimer.start(calculate_total_time(stage.time, value, waterGrowSpeedRatio))
		#
		#growRate = value
#
#var incomeRate : float = 1
#var scoreRate : float = 1:
	#set(value):
		#value = max(value, 0)
		#scoreRate = value
#
#var water : int = 0:
	#set(value):
		#value = max(value, 0)
		#if isPlant:
			#if (value < waterNeeded):
				#if value == 0:
					#noWaterNode.visible = true
					#warningWaterNode.visible = false
				#else:
					#noWaterNode.visible = false
					#warningWaterNode.visible = true
				#
			#else:
				#noWaterNode.visible = false
				#warningWaterNode.visible = false
			#
			#if waterNeeded != 0:
				#waterGrowSpeedRatio = float(value) / float(waterNeeded)
			#else:
				#waterGrowSpeedRatio = 1.
			##growManager.totalGrowTime /= waterGrowSpeedRatio
			#growTimer.start(calculate_total_time(stage.time, growRate, waterGrowSpeedRatio))
		#water = value
#
#var waterGrowSpeedRatio : float = 1.
#
#var pos : Vector2
#
#var stage : GrowStage
#var stages : Array[GrowStage]
#var stageIndex : int = 0
#var growTimer : Timer
#
#var noWaterNode : Sprite3D
#var warningWaterNode : Sprite3D
#
#
#
## READY ############################################################
#func _ready():
	#
	#warningWaterNode = load("res://Plants/warning_water_logo.tscn").instantiate()
	#warningWaterNode.visible = false
	#add_child(warningWaterNode)
	#
	#noWaterNode = load("res://Plants/no_water_logo.tscn").instantiate()
	#noWaterNode.visible = false
	#add_child(noWaterNode)
	#
	#create_modifier_zones()
	#rotation.y = randf_range(0, 2*PI)
	#
	#if isPlant:
		#
		#stages = growManager.growStages
		#stage = stages[stageIndex]
		#
		#growTimer = Timer.new()
		#growTimer.one_shot = true
		#growTimer.connect("timeout", timer_end)
		#add_child(growTimer)
	#
	#next_stage()
#
#func next_stage():
	#if (stageIndex < stages.size()):
		#anim.play("startStage")
		#stage = stages[stageIndex]
		#meshInstance.mesh = stage.mesh
		#
		#growTimer.start( calculate_total_time(stage.time, growRate, waterGrowSpeedRatio) )
		#
		#stageIndex += 1
#
#func reset_growth():
	#stageIndex = 0
	#lifetime = 0
	#next_stage()
#
#func timer_end():
	#if (stageIndex < stages.size()):
		#anim.play("endStage")
		#if !anim.is_connected("animation_finished", animation_finished):
			#anim.connect("animation_finished", animation_finished)
#
#func animation_finished(animation : StringName):
	#if animation == "endStage":
		#next_stage()
#
#var lifetime : float
#@export var animationScale : float = 0.
#
#func _physics_process(delta):
	#if isPlant:
		#lifetime += delta * waterGrowSpeedRatio * growRate
		#var timeRatio = clamp( lifetime / growManager.totalGrowTime + 0.4, 0.4, 1.)
		#
		#scale = (Vector3(1, 1, 1) * timeRatio * animationScale * clamp(incomeRate,0,2) * clamp(scoreRate,0,2) ).clamp(Vector3(0,0,0), Vector3(3,3,3))
#
#func calculate_total_time(baseTime : float, growRate, waterGrowSpeedRatio):
	#if growRate == 0 or waterGrowSpeedRatio == 0:
		#return 9999999999
	#return stage.time / (growRate * waterGrowSpeedRatio)
#
#func _exit_tree():
	#delete_modifier_zones()


#DEFAULTS ######################################################


func create_modifier_zones():
	push_warning("tried to call default function")

func delete_modifier_zones():
	push_warning("tried to call default function")

func get_highlight_zones() -> Array[Vector2]:
	push_warning("tried to call default function")
	return []






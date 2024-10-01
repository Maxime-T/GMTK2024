extends Node3D
class_name Plant

@export_category("Setup")
@export var growManager : GrowManager
@export var meshInstance : MeshInstance3D

@export_category("Plant Info")
@export var plantName : String = ""
@export var isPlant : bool = true

@export var stats : Stats

var gridPos : Vector2 = Vector2()
var plantGrid : PlantGrid

#######
var animationScale : float = 0.
var harvestable : bool = false
var pauseScaleUpdate : bool = false

func _ready():
	scale = Vector3(0,0,0)
	########## OBSERVABLE
	stats.growSpeed.setFunction = func(v) : growManager.growSpeed = v
	#########
	add_modifiers()
	
	play_aparition_animation()
	meshInstance.mesh = growManager.growStages[0].mesh
	
	#Conect Signals
	growManager.stage_changed.connect(on_stage_changed)
	growManager.fully_grown.connect(on_fully_grown)

func _physics_process(delta):
	update_scale()

func update_scale():
	if isPlant && !pauseScaleUpdate:
		scale = Vector3.ONE * animationScale * (growManager.growPourcent+0.2 / (1+0.2))
	else:
		scale = Vector3.ONE * animationScale

func on_stage_changed(newStage : GrowStage):
	var t = create_tween()
	pauseScaleUpdate = true
	t.tween_property(self, "animationScale", 0.3, 0.1)
	t.tween_callback(meshInstance.set_mesh.bind(newStage.mesh))
	t.tween_callback(set_pause_scale_update.bind(false))
	t.tween_property(self, "animationScale", 1.0, 0.1)

func set_pause_scale_update(value : bool) -> void:
	pauseScaleUpdate = value

func on_fully_grown():
	if isPlant:
		harvestable = true
		meshInstance.get_material_overlay().set_shader_parameter("enabled",true)

func play_aparition_animation() -> void:
	animationScale = 0
	var t = create_tween()
	t.tween_property(self, "animationScale", 1., 0.1)

func play_disparition_animation() -> void:
	var t = create_tween()
	t.tween_property(self, "animationScale", 0.2, 0.1)

func harvest():
	if harvestable:
		#print(income.calculate_value())
		#Global.sun += score.calculate_value()
		Global.gold += stats.income.calculate_value()
		reset_growth()

func reset_growth():
	growManager.reset()
	meshInstance.get_material_overlay().set_shader_parameter("enabled", false)
	harvestable = false

func get_adjacent_tile(v : Vector2) -> PlantGrid.Tile:
	return plantGrid.get_tile(gridPos.x+v.x, gridPos.y+v.y)

@onready var values = stats.get_property_list().filter(func(e): return e.class_name == &"ModifiableValue")
func update_modifiers(mods : Array[PlantGrid.Tile.TileModifier]):
	for modifiable in values:
		(stats.get(modifiable.name) as ModifiableValue).removeAllModifiers()
	
	for m in mods:
		var modifiableValue : ModifiableValue = stats.get(m.property) as ModifiableValue
		modifiableValue.add_modifier(m.mod.origin, m.mod.type, m.mod.value)






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
func add_modifiers():
	push_warning("tried to call default function")

func get_highlight_zones() -> Array[Vector2]:
	push_warning("tried to call default function")
	return []

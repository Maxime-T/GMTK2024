extends Control
class_name Card

var PlantGridNode : PlantGrid
var ComponentDescriptionLabel : RichTextLabel
var DescriptionControlNode : Control

var CardName : String
var CardDescription : String
@export var GCScene : PackedScene


var GoldCost : float
var waterNeeded : int
var PollutionProd : float
var SunProd : float
var GrowTime : float
var Income : float

@export_group("Labels")
@export var GoldCostLabel : Label
@export var WaterNeededLabel : Label
@export var PollutionLabel : Label
@export var TimeLabel : Label
@export var SunProdLabel : Label
@export var IncomeLabel : Label

@export var CardNameLabel : Label

@export_group("HBoxs")
@export var GoldCostBox : HBoxContainer
@export var WaterCostBox : HBoxContainer
@export var PollutionBox : HBoxContainer
@export var TimeBox : HBoxContainer
@export var SunProdBox : HBoxContainer
@export var IncomeBox : HBoxContainer

var scale_size = 1.2

var confirmed : bool:
	set(val):
		if not val:
			scale = Vector2(1,1)
		confirmed = val


var GCNode : GridComponent

func _ready():
	if GCScene == null: #Juste pour éviter un crash si on a int
		queue_free()
		return
	
	GCNode = GCScene.instantiate()
	
	if GCNode.has_method("get_description"):
		CardDescription = GCNode.get_description()
	
	CardName = GCNode.component_name
	CardNameLabel.text = CardName
	
	GoldCost = GCNode.stats.goldCost.calculate_value()
	GoldCostLabel.text = str(GoldCost)
	if GoldCost == 0:
		GoldCostBox.queue_free()
	
	PollutionProd = GCNode.stats.pollutionGeneration.calculate_value()
	PollutionLabel.text = str(PollutionProd)
	if PollutionProd == 0:
		PollutionBox.queue_free()
	
	SunProd = GCNode.stats.score.calculate_value()
	SunProdLabel.text = str(SunProd)
	if SunProd == 0:
		SunProdBox.queue_free()
	
	Income = GCNode.stats.score.calculate_value()
	IncomeLabel.text = str(Income)
	if Income == 0:
		IncomeBox.queue_free()
	
	
	waterNeeded = round(GCNode.stats.waterNeeded.calculate_value())
	WaterNeededLabel.text = str(waterNeeded)
	if waterNeeded == 0:
		WaterCostBox.queue_free()
	
	#REAL PLANT SPECIFIC
	if GCNode is Plant:
		GrowTime = GCNode.growManager.calculate_grow_time()
		TimeLabel.text = str(GrowTime)
		if GrowTime == 0:
			TimeBox.queue_free()
	else:
		TimeBox.queue_free()

func _unhandled_input(event):
	if event.is_action_pressed("right click") and has_focus():
		GlobalSignals.plant_selected.emit(null)
		release_focus()
		confirmed = false
	##Suprimer seulement si elle est bien placé
	if event.is_action_pressed("click") and confirmed:
		var intersection_point : Vector2 = PlantGridNode.get_mouse_tile_position()
		if PlantGridNode.is_tile_free(intersection_point.x, intersection_point.y) and Global.gold >= GoldCost:
			PlantGridNode.create_object(intersection_point.x, intersection_point.y, GCScene)
			Global.gold -= GoldCost
			Global.pollution += PollutionProd
			GlobalSignals.plant_selected.emit(null)
			queue_free()
			Global.CardPlayed.emit()

func _on_mouse_entered():
	if confirmed:
		return
	scale = Vector2(scale_size,scale_size)


func _on_mouse_exited():
	if confirmed:
		return
	scale = Vector2(1,1)


func _on_focus_entered():
	GlobalSignals.plant_selected.emit(GCNode)
	confirmed = true
	ComponentDescriptionLabel.text = CardDescription
	DescriptionControlNode.position = Vector2(0,294)


func _on_focus_exited():
	confirmed = false
	ComponentDescriptionLabel.text = ""
	DescriptionControlNode.position = Vector2(-400,294)

extends Control
class_name Card

var PlantGridNode : PlantGrid
var PlantDescriptionLabel : RichTextLabel
var DescriptionControlNode : Control

var CardName : String
var CardDescription : String
@export var PlantScene : PackedScene


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


var PlantNode : Plant
func _ready():
	if PlantScene == null: #Juste pour éviter un crash si on a int
		queue_free()
		return
	
	PlantNode = PlantScene.instantiate()
	
	if PlantNode.has_method("get_description"):
		CardDescription = PlantNode.get_description()
	
	CardName = PlantNode.plantName
	CardNameLabel.text = CardName
	
	GoldCost = PlantNode.GoldCost
	GoldCostLabel.text = str(GoldCost)
	if GoldCost == 0:
		GoldCostBox.queue_free()
	
	PollutionProd = PlantNode.pollutionGeneration
	PollutionLabel.text = str(PollutionProd)
	if PollutionProd == 0:
		PollutionBox.queue_free()
	
	SunProd = PlantNode.sunProd
	SunProdLabel.text = str(SunProd)
	if SunProd == 0:
		SunProdBox.queue_free()
	
	Income = PlantNode.income
	IncomeLabel.text = str(Income)
	if Income == 0:
		IncomeBox.queue_free()
	
	#REAL PLANT SPECIFIC
	waterNeeded = PlantNode.waterNeeded
	WaterNeededLabel.text = str(waterNeeded)
	if waterNeeded == 0:
		WaterCostBox.queue_free()
	
	if PlantNode.isPlant:
		GrowTime = PlantNode.growManager.calculate_grow_time()
		TimeLabel.text = str(GrowTime)
		if GrowTime == 0:
			TimeBox.queue_free()
	else:
		TimeBox.queue_free()

func _unhandled_input(event):
	if event.is_action_pressed("right click") and has_focus():
		PlantGridNode.selectedPlant = null
		release_focus()
		confirmed = false
	##Suprimer seulement si elle est bien placé
	if event.is_action_pressed("click") and confirmed:
		var intersection_point = PlantGridNode.get_mouse_tile_position()
		if PlantGridNode.is_tile_free(intersection_point.x, intersection_point.z) and Global.gold >= GoldCost:
			PlantGridNode.create_plant(intersection_point.x, intersection_point.z, PlantScene)
			Global.gold -= GoldCost
			Global.pollution += PollutionProd
			PlantGridNode.selectedPlant = null
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
	PlantGridNode.selectedPlant = PlantNode
	confirmed = true
	PlantDescriptionLabel.text = CardDescription
	DescriptionControlNode.position = Vector2(0,294)


func _on_focus_exited():
	confirmed = false
	PlantDescriptionLabel.text = ""
	DescriptionControlNode.position = Vector2(-400,294)

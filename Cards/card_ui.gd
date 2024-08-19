extends Control
class_name Card

@export var CardName : String = ""

@export_category("Card stats")
# -1 pour enlever
@export var GoldCost : float = 0
@export var WaterCost : float = -1
@export var PollutionProd : float = -1
@export var SunProd : float = -1
@export var GrowTime : float = -1
@export var Income : float = -1

@export_group("Labels")
@export var GoldCostLabel : Label
@export var WaterCostLabel : Label
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

var scale_size = 1.3

var confirmed : bool:
	set(val):
		if not val:
			scale = Vector2(1,1)
		confirmed = val


func _ready():
	CardNameLabel.text = CardName
	if GoldCost == -1:
		GoldCostBox.queue_free()
	if WaterCost == -1:
		WaterCostBox.queue_free()
	if PollutionProd == -1:
		PollutionBox.queue_free()
	if GrowTime == -1:
		TimeBox.queue_free()
	if SunProd == -1:
		SunProdBox.queue_free()
	if Income == -1:
		IncomeBox.queue_free()
	

func _input(event):
	if event.is_action_pressed("right click"):
		release_focus()
		confirmed = false
	##Suprimer seulement si elle est bien placé
	if event.is_action_pressed("click") and confirmed:
		queue_free()

func _on_mouse_entered():
	if confirmed:
		return
	scale = Vector2(scale_size,scale_size)


func _on_mouse_exited():
	if confirmed:
		return
	scale = Vector2(1,1)


func _on_focus_entered():
	confirmed = true


func _on_focus_exited():
	confirmed = false

extends Card
class_name Consomable

@export var consomable_name : String 
@export var consomable_description : String
@export var consomable_cost : float
@export var target_types : Array[String]

func _ready():
	
	CardName = consomable_name
	CardNameLabel.text = CardName
	
	GoldCost = consomable_cost
	GoldCostLabel.text = str(GoldCost)
	
	PollutionBox.queue_free()
	SunProdBox.queue_free()
	IncomeBox.queue_free()
	WaterCostBox.queue_free()
	TimeBox.queue_free()

func _unhandled_input(event):
	if event.is_action_pressed("right click") and has_focus():
		GlobalSignals.plant_selected.emit(null)
		release_focus()
		confirmed = false
	##Suprimer seulement si elle est bien placé
	if event.is_action_pressed("click") and confirmed:
		var inter := PlantGridNode.get_mouse_tile_position()
		if PlantGridNode.is_inbound(inter.x, inter.y) and Global.gold >= GoldCost and PlantGridNode.get_grid_component(inter.x,inter.y) != null:
			
			for target_type in target_types:
				if target_type in PlantGridNode.get_grid_component(inter.x,inter.y).get_groups():
					consomable_specific_effect(inter.x, inter.y)
					
					Global.gold -= GoldCost
					GlobalSignals.plant_selected.emit(null)
					queue_free()
					Global.CardPlayed.emit()
					break

#Par défaut ca permet d'enlever quelque chose
func consomable_specific_effect(x,y):
	PlantGridNode.remove_object(x,y)

func _on_focus_entered():
	confirmed = true
	ComponentDescriptionLabel.text = consomable_description
	DescriptionControlNode.position = Vector2(0,294)


func _on_focus_exited():
	confirmed = false
	ComponentDescriptionLabel.text = ""
	DescriptionControlNode.position = Vector2(-400,294)

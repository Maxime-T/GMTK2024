extends Card
class_name Consomable

@export var consomable_name : String 
@export_multiline var consomable_description : String
@export var consomable_cost : float
@export var target_types : Array[String]
@export var specific_over_general : bool = false

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
		if PlantGridNode.is_inbound(inter.x, inter.y) and Global.gold >= GoldCost:
			if !specific_over_general:
				if consomable_general_effect(inter.x, inter.y):
					post_effect_stuff()
					return
			
			if PlantGridNode.get_grid_component(inter.x,inter.y) != null:
				if Global.check_targeted_groups_is_in_groups(target_types, PlantGridNode.get_grid_component(inter.x,inter.y).get_groups()):
					if consomable_specific_effect_on_grid_component(inter.x, inter.y):
						post_effect_stuff()

func consomable_general_effect(x,y) -> bool:
	return true

#Par défaut ca permet d'enlever quelque chose
func consomable_specific_effect_on_grid_component(x,y) -> bool:
	PlantGridNode.remove_object(x,y)
	return true

func _on_focus_entered():
	confirmed = true
	ComponentDescriptionLabel.text = consomable_description
	DescriptionControlNode.position = Vector2(0,294)


func _on_focus_exited():
	confirmed = false
	ComponentDescriptionLabel.text = ""
	DescriptionControlNode.position = Vector2(-400,294)

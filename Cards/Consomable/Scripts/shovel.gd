extends Card

func _ready():
	
	CardName = "Shovel"
	CardNameLabel.text = CardName
	
	GoldCost = 100
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
			if PlantGridNode.get_plant(inter.x,inter.y) != null or PlantGridNode.get_tools(inter.x,inter.y) != null: #Faut pas détruire n'importe quel obstacle
				PlantGridNode.remove_object(inter.x, inter.y)
				Global.gold -= GoldCost
				GlobalSignals.plant_selected.emit(null)
				queue_free()
				Global.CardPlayed.emit()


func _on_focus_entered():
	confirmed = true
	ComponentDescriptionLabel.text = "Destroy an object on one tile."
	DescriptionControlNode.position = Vector2(0,294)


func _on_focus_exited():
	confirmed = false
	ComponentDescriptionLabel.text = ""
	DescriptionControlNode.position = Vector2(-400,294)

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
		PlantGridNode.selectedPlant = null
		release_focus()
		confirmed = false
	##Suprimer seulement si elle est bien placé
	if event.is_action_pressed("click") and confirmed:
		var intersection_point = PlantGridNode.get_mouse_tile_position()
		if PlantGridNode.is_inside(intersection_point.x, intersection_point.z) and Global.gold >= GoldCost:
			if PlantGridNode.data[intersection_point.x][intersection_point.z] != null:
				PlantGridNode.data[intersection_point.x][intersection_point.z].queue_free()
				PlantGridNode.data[intersection_point.x][intersection_point.z] = null
				Global.gold -= GoldCost
				PlantGridNode.selectedPlant = null
				queue_free()
				Global.CardPlayed.emit()


func _on_focus_entered():
	confirmed = true
	PlantDescriptionLabel.text = "Destroy an object"
	DescriptionControlNode.position = Vector2(0,294)


func _on_focus_exited():
	confirmed = false
	PlantDescriptionLabel.text = ""
	DescriptionControlNode.position = Vector2(-400,294)

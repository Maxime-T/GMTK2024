extends CanvasLayer

@export var CardsContainer : HBoxContainer

var common_cards : Array[PackedScene] = [preload("res://Cards/card_ui.tscn")]

func _on_cards_container_child_exiting_tree(node):
	if CardsContainer.get_child_count()-1 <= 1:
		for i in range(4):
			var instance = common_cards[randi_range(0, common_cards.size())-1].instantiate()
			CardsContainer.add_child.call_deferred(instance)
		

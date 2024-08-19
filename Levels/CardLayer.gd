extends CanvasLayer

enum {COMMON, RARE, EPIC, LENGENDARY}

@export var CardsContainer : HBoxContainer
@export var PlantGridNode : PlantGrid

var common_prob : float = 0.69
var rare_prob : float = 0.25
var epic_prob : float = 0.05
var legendary_prob : float = 0.01

var common_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn"), preload("res://Cards/CarteTomate.tscn")]
var rare_cards : Array[PackedScene] = [preload("res://Cards/card_ui.tscn")]
var epics_cards : Array[PackedScene] = [preload("res://Cards/card_ui.tscn")]
var lengendary_cards : Array[PackedScene] = [preload("res://Cards/card_ui.tscn")]

func _ready():
	for i in range(4):
		generate_cards()

func _on_cards_container_child_exiting_tree(node):
	if CardsContainer.get_child_count()-1 <= 1:
		for i in range(4):
			generate_cards()


func generate_cards():
	var gen = randf()
	
	if gen <= legendary_prob:
		create_cards(LENGENDARY)
	elif gen < legendary_prob + epic_prob:
		create_cards(EPIC)
	elif gen < legendary_prob + epic_prob + rare_prob:
		create_cards(RARE)
	else:
		create_cards(COMMON)
	
			
func create_cards(RARITY):
	var instance
	
	match RARITY:
		COMMON:
			instance = common_cards[randi_range(0, common_cards.size())-1].instantiate()
		RARE:
			instance = rare_cards[randi_range(0, rare_cards.size())-1].instantiate()
		EPIC:
			instance = epics_cards[randi_range(0, epics_cards.size())-1].instantiate()
		LENGENDARY:
			instance = lengendary_cards[randi_range(0, lengendary_cards.size())-1].instantiate()
	
	instance.PlantGridNode = PlantGridNode
	CardsContainer.add_child.call_deferred(instance)



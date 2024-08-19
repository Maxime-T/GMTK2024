extends CanvasLayer

enum {COMMON, RARE, EPIC, LENGENDARY}

@export var CardsContainer : HBoxContainer
@export var PlantGridNode : PlantGrid

var common_prob : float = 0.69
var rare_prob : float = 0.25
var epic_prob : float = 0.05
var legendary_prob : float = 0.01

var common_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn"),preload("res://Cards/CarteTomate.tscn"),preload("res://Cards/carte_cucumber.tscn"),
preload("res://Cards/carte_corn.tscn")]

var rare_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn")]
var epics_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn")]
var lengendary_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn")]

@export var RerollButton : Button
@export var baseRerollCost : float = 100
var currentRerollCost : float = baseRerollCost

func _ready():
	Global.CardPlayed.connect(carte_played)
	RerollButton.text = "Reroll : " + str(currentRerollCost) + " g"
	for i in range(5):
		generate_cards()

func carte_played():
	if CardsContainer.get_child_count()-1 <= 1:
		clear_cards()
		for i in range(5):
				generate_cards()
		if currentRerollCost > baseRerollCost:
			currentRerollCost /= 2
			RerollButton.text = "Reroll : " + str(currentRerollCost) + " g"

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

func clear_cards():
	for child in CardsContainer.get_children():
			child.queue_free()


func _on_reroll_pressed():
	if Global.gold >= currentRerollCost:
		Global.gold -= currentRerollCost
		clear_cards()
		currentRerollCost *= 2
		RerollButton.text = "Reroll : " + str(currentRerollCost) + " g"
	
		for i in range(5):
			generate_cards()

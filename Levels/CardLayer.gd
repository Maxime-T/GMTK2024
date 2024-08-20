extends CanvasLayer

enum {COMMON, RARE, EPIC, LENGENDARY}

@export var CardsContainer : HBoxContainer
@export var PlantGridNode : PlantGrid
@export var PlantDescriptionLabel : RichTextLabel
@export var DescriptionControlNode : Control

@export var AutoRerollLAb : Label
var carteEnMain : int = 5

var common_prob : float = 0.69
var rare_prob : float = 0.25
var epic_prob : float = 0.05
var legendary_prob : float = 0.01

var common_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn"),preload("res://Cards/CarteTomate.tscn"),preload("res://Cards/carte_cucumber.tscn"),
preload("res://Cards/carte_corn.tscn"),preload("res://Cards/carte_wheat.tscn"), preload("res://Cards/carte_carrot.tscn")]

var rare_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn"), preload("res://Cards/carte_well.tscn"),
preload("res://Cards/carte_pumpkin.tscn")]
var epics_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn")]
var lengendary_cards : Array[PackedScene] = [preload("res://Cards/carte_aubergine.tscn")]

@export var RerollButton : Button
@export var ExpandButton : Button
@export var baseRerollCost : float = 100
var currentRerollCost : float = baseRerollCost

func _ready():
	Global.CardPlayed.connect(carte_played)
	RerollButton.text = "Reroll : " + str(currentRerollCost) + " g"
	ExpandButton.text = "Expand : " +str(expand_cost) + " g"
	for i in range(5):
		generate_cards()

func carte_played():
	carteEnMain -= 1
	AutoRerollLAb.text = "Use " + str(carteEnMain-1) + " cards to auto-reroll"
	if CardsContainer.get_child_count()-1 <= 1:
		clear_cards()
		for i in range(5):
				generate_cards()
		if currentRerollCost > baseRerollCost:
			currentRerollCost /= 2
			RerollButton.text = "Reroll : " + str(currentRerollCost) + " g"

func generate_cards():
	carteEnMain = 5
	AutoRerollLAb.text = "Use " + str(carteEnMain-1) + " cards to auto-reroll"
	
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
	
	instance.DescriptionControlNode = DescriptionControlNode
	instance.PlantGridNode = PlantGridNode
	instance.PlantDescriptionLabel = PlantDescriptionLabel
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

var expand_cost_list : Array[float] = [10, 100, 500, 2500, 5000, 10000, 50000, 99999, 42]
var expand_list_index : int = 1
var expand_cost : float = expand_cost_list[0]

func _on_expand_pressed():
	#Global.sun += 100
	if Global.gold > expand_cost:
		Global.gold -= expand_cost
		expand_cost = expand_cost_list[expand_list_index]
		expand_list_index += 1
		PlantGridNode.expand_map()
		if expand_list_index == expand_cost_list.size():
			ExpandButton.text = "Max size reached"
			ExpandButton.disabled = true
			return
		ExpandButton.text = "Expand : " +str(expand_cost) + " g"

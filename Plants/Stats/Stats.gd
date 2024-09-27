@tool
extends Resource
class_name Stats

@export_group("Costs")
@export var goldCost : ModifiableValue
@export var waterNeeded : ModifiableValue
@export var pollutionGeneration : ModifiableValue

@export_group("Production")
@export var income : ModifiableValue
@export var score : ModifiableValue

@export_group("modifiers")
@export var water : ModifiableValue
@export var growSpeed : ModifiableValue

func _init() -> void:
	goldCost = ModifiableValue.new()
	waterNeeded = ModifiableValue.new()
	pollutionGeneration = ModifiableValue.new()

	income = ModifiableValue.new()
	score = ModifiableValue.new()

	water = ModifiableValue.new()
	growSpeed = ModifiableValue.new(1)

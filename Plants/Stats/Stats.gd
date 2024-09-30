@tool
extends Resource
class_name Stats

var values : Array[Dictionary]

@export_group("ModifiableValue")
#costs
var goldCost : ModifiableValue
var waterNeeded : ModifiableValue
var pollutionGeneration : ModifiableValue
#Production
var income : ModifiableValue
var score : ModifiableValue
#modifiers
var water : ModifiableValue
var growSpeed : ModifiableValue

func _init() -> void:
	resource_local_to_scene = true
	goldCost = ModifiableValue.new()
	waterNeeded = ModifiableValue.new()
	pollutionGeneration = ModifiableValue.new()

	income = ModifiableValue.new()
	score = ModifiableValue.new()

	water = ModifiableValue.new()
	growSpeed = ModifiableValue.new(1)
	
	values = get_property_list().filter(func(e): return e.class_name == &"ModifiableValue")

func _get_property_list() -> Array:
	var proprieties : Array[Dictionary]
	
	for e in values:
		proprieties.append({name = e.name+":baseValue", type = TYPE_FLOAT})
	
	return proprieties

func _get(property: StringName):
	if property.ends_with(":baseValue"):
		var l = ":baseValue".length()
		return get(property.erase(property.length()-l,l)).baseValue
	return null

func _set(property: StringName, value) -> bool:
	if property.ends_with(":baseValue"):
		var l = ":baseValue".length()
		get(property.erase(property.length()-l,l)).baseValue = value
		return true
	return false

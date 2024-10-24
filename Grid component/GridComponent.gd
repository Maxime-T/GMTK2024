extends Node3D
class_name GridComponent

@export var component_name : String = ""
@export var meshInstance : MeshInstance3D

@export var stats : Stats

@export var tracked_groups : Array[String] = ["Plant"]
@export var targeted_groups : Array[String] = ["Plant"]

var gridPos : Vector2 = Vector2()
var plantGrid : PlantGrid
var values

func _ready() -> void:
	if stats != null:
		values = stats.get_property_list().filter(func(e): return e.class_name == &"ModifiableValue")
		stats.water.setFunction = on_water_set
		Global.pollution += stats.pollutionGeneration.calculate_value()
	
	if !tree_exited.is_connected(_on_tree_exited):
			tree_exited.connect(_on_tree_exited)
	
	add_modifiers()

func _on_tree_exited() -> void:
	if stats != null:
		Global.pollution -= stats.pollutionGeneration.calculate_value()

func add_modifiers():
	pass

func get_highlight_zones() -> Array[Vector2]:
	return []

func get_adjacent_tile(v : Vector2) -> PlantGrid.Tile:
	return plantGrid.get_tile(gridPos.x+v.x, gridPos.y+v.y)

func get_adjacent_obstacle(vector : Vector2) -> Obstacle:
	var tile = get_adjacent_tile(vector)
	if tile != null and tile.grid_component != null and tile.grid_component is Obstacle:
		return tile.grid_component
	return null

func get_adjacent_plant(vector : Vector2) -> Plant:
	var tile = get_adjacent_tile(vector)
	if tile != null and tile.grid_component != null and tile.grid_component is Plant:
		return tile.grid_component
	return null

func get_adjacent_tools(vector : Vector2) -> Tools:
	var tile = get_adjacent_tile(vector)
	if tile != null and tile.grid_component != null and tile.grid_component is Tools:
		return tile.grid_component
	return null

func on_water_set(water_amout):
	print(self, water_amout)

var popup3D_scene = load("res://HUD items/popup3D.tscn")
func spawn_popup():
	var popup3d : Popup3D = popup3D_scene.instantiate()
	popup3d.set_grid_component(self)
	add_child(popup3d)

##les modifier de plante ne doivent JAMAIS etre modifier directement, utiliser plutôt les fonction de sa TILE
func update_modifiers(mods : Array[PlantGrid.Tile.TileModifier]):
	for modifiable in values:
		(stats.get(modifiable.name) as ModifiableValue).removeAllModifiers()
	
	for tile_modifier in mods:
		var modifiableValue : ModifiableValue = stats.get(tile_modifier.property) as ModifiableValue
		
		if Global.check_targeted_groups_is_in_groups(tile_modifier.target_types, get_groups()):
			modifiableValue.add_modifier(tile_modifier.mod.origin, tile_modifier.mod.type, tile_modifier.mod.value)

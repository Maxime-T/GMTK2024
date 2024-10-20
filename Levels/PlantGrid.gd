extends Node3D
class_name PlantGrid

@export var size : int = 20
@export var tileSize : float = 0.8

@export var X_fences : Node3D
@export var Z_fences : Node3D

var mouseTilePosition : Vector3
var selectedObject : GridComponent

var current_size : int = 4
var current_fence : int = 2
#################################
		   #Array[Array[Tile]]
var data : Array = []

class Tile:
	var grid_component : GridComponent:
		set(value):
			grid_component = value
			if grid_component is Plant:
				plant_update_modifiers()
	
	var ground : GroundTile
	var locked : bool
	var modifiers : Array[TileModifier]
	
	var tilePos : Vector2
	
	signal plant_change(new_plant, old_plant)
	
	func _init(_grid_component : Plant, _ground : GroundTile):
		grid_component = _grid_component
		ground = _ground
		locked = true
	
	func add_modifier(property : String, target_types : Array[String], mod : Modifier):
		var tileModifier := TileModifier.new(property, target_types, mod)
		modifiers.append(tileModifier)
		plant_update_modifiers()
		if !mod.origin.tree_exited.is_connected(remove_all_modifier_from_source):
			mod.origin.tree_exited.connect(remove_all_modifier_from_source.bind(mod.origin))
	
	func remove_modifier(tileModifier : TileModifier):
		modifiers.erase(tileModifier)
		plant_update_modifiers()
	
	func plant_update_modifiers():
		if grid_component != null and grid_component is Plant:
			grid_component.update_modifiers(modifiers)
	
	func remove_all_modifier_from_source(source_plant : Plant):
		var counter : int = 0
		for i in range(modifiers.size()):
			if modifiers[counter].mod.origin == source_plant:
				modifiers.erase(modifiers[counter])
				counter -= 1
			counter += 1
		plant_update_modifiers()
	
	func debug_print_modifiers():
		print(modifiers)
	
	class TileModifier:
		var property : String
		var mod : Modifier
		var target_types : Array[String]
		
		func _init(_property : String, _target_types : Array[String], _mod : Modifier) -> void:
			property = _property
			target_types = _target_types
			mod = _mod
		
		func _to_string() -> String:
			return str(property) + " " + str(target_types) + " " + str(mod)

func get_tile(x : float, y : float) -> Tile:
	x = int(round(x))
	y = int(round(y))
	if is_inbound(x,y):
		return data[x][y]
	return null

func get_ground(x : float, y : float) -> GroundTile:
	x = round(x)
	y = round(y)
	if is_inbound(x,y):
		return data[x][y].ground
	return null

func get_plant(x : float,y : float) -> Plant:
	x = round(x) ; y = round(y)
	if is_inbound(x,y) and data[x][y].grid_component is Plant:
		return data[x][y].grid_component
	return null

func get_grid_component(x,y) -> GridComponent:
	x = round(x) ; y = round(y)
	if is_inbound(x,y):
		return data[x][y].grid_component
	return null

func get_tools(x,y) -> Tools:
	x = round(x) ; y = round(y)
	if is_inbound(x,y) and data[x][y].grid_component is Tools:
		return data[x][y].grid_component
	return null
#################################


func _ready():
	GlobalSignals.connect("plant_selected", _on_plant_selected)
	
	init_data()
	init_ground()
	
	create_plant(0, 0, load("res://Plants/Scene/tomato.tscn"))
	create_plant(1, 0, load("res://Plants/Scene/tomato.tscn"))

func _physics_process(_delta):
	mouse_highlight()
	#click_input()

func click_input() -> void:
	if Input.is_action_just_pressed("click"):
		var pos : Vector2 = get_mouse_tile_position()
		var plant : Plant = get_plant(pos.x ,pos.y)
		if plant != null && is_inbound(pos.x ,pos.y):
			plant.harvest()

func _unhandled_input(event):
	if (event is InputEventMouseMotion and event.pressure == 1) or event.is_action_pressed("click"):
		var pos : Vector2 = get_mouse_tile_position()
		var plant : Plant = get_plant(pos.x ,pos.y)
		if plant != null && is_inbound(pos.x ,pos.y):
			plant.harvest()

func init_data() -> void:
	for i in range(size):
		data.append([])
		for j in range(size):
			var t = Tile.new(null, null)
			t.tilePos = Vector2(i,j)
			data[i].append(t)
	
	for x in range(current_size):
		for y in range(current_size):
			get_tile(x,y).locked = false

func init_ground() -> void:
	for x in range(size):
		for y in range(size):
			create_ground(x,y, null)

func is_tile_free(x:float, y:float) -> bool:
	x = round(x) ; y = round(y)
	var tile := get_tile(x,y)
	if tile != null and !tile.locked:
		if get_grid_component(x,y) == null:
			return true
	return false

##Deprecated function -> use create_object() instead
func create_plant(x : float, y : float, plantScene : PackedScene) -> void:
	x = round(x) ; y = round(y)
	var plant : Plant = plantScene.instantiate()
	plant.plantGrid = self
	plant.gridPos = Vector2(x,y)
	plant.position = get_real_position(x,y)
	add_child(plant, true)
	
	var tile := get_tile(x,y)
	tile.emit_signal("plant_change", plant, tile.grid_component)
	tile.grid_component = plant

##Deprecated function -> use remove_object() instead
func remove_plant(x : float, y : float):
	x = round(x) ; y = round(y)
	var tile := get_tile(x,y)
	tile.emit_signal("plant_change", null, tile.grid_component)
	get_plant(x,y).queue_free()
	tile.grid_component = null

func create_object(x : float, y : float, object_scene : PackedScene) -> void:
	x = round(x) ; y = round(y)
	if get_grid_component(x,y) != null:
		push_error("tried to create an object onto another object")
		return
	
	var grid_component : GridComponent = object_scene.instantiate()
	grid_component.plantGrid = self
	grid_component.gridPos = Vector2(x,y)
	grid_component.position = get_real_position(x,y)
	add_child(grid_component, true)
	
	var tile := get_tile(x,y)
	tile.emit_signal("plant_change", grid_component, tile.grid_component)
	tile.grid_component = grid_component
	
func remove_object(x:float, y:float):
	x = round(x) ; y = round(y)
	if get_grid_component(x,y) == null:
		push_error("tried to remove a non existant object")
		return
	
	var tile := get_tile(x,y)
	tile.emit_signal("plant_change", null, tile.grid_component)
	get_grid_component(x,y).queue_free()
	tile.grid_component = null

func create_ground( x:int, y:int, _type : PackedScene) -> void:
	var ground : GroundTile = load("res://Plants/Grounds/ground_tile.tscn").instantiate()
	data[x][y].ground = ground
	ground.position = get_real_position(x,y)
	add_child(ground)

func get_real_position(x:float, y:float) -> Vector3:
	x = round(x) ; y = round(y)
	return Vector3(x*tileSize+tileSize/2, 0, y*tileSize+tileSize/2)

func get_real_position_v(pos : Vector3) -> Vector3:
	return Vector3(pos.x*tileSize+tileSize/2, 0, pos.y*tileSize+tileSize/2)

func get_mouse_tile_position() -> Vector2:
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var t = -ray_origin.y / ray_direction.y
	var intersection_point : Vector3 = ray_origin + t * ray_direction
	intersection_point /= tileSize
	if !is_inbound(intersection_point.x, intersection_point.z):
		return Vector2(-1,-1)
	return Vector2(intersection_point.x, intersection_point.z).floor()

func mouse_highlight() -> void:
	var pos : Vector2 = get_mouse_tile_position()
	if is_inbound(pos.x, pos.y):
		var tile : Tile = get_tile(pos.x, pos.y)
		tile.ground.set_highlight(Color(0.2,0.2,0.2,0))
	
	if selectedObject != null:
		for v in selectedObject.get_highlight_zones():
			var coord := pos+v
			var ground := get_ground(coord.x, coord.y)
			if ground != null:
				ground.set_highlight(Color(0.1,0.1,0.1,0))

func is_inbound(x : float, y : float) -> bool:
	return (x>=0 && x<size) && (y>=0 && y<size)

func _on_plant_selected(object : GridComponent):
	selectedObject = object

func unlock_new_tiles(new_size: int) -> void:
	if new_size <= current_size:
		return

	for x in range(current_size, new_size):
		for y in range(current_size):  # Débloquer les Tiles dans les colonnes déjà débloquées
			get_tile(x, y).locked = false
	
	for y in range(current_size, new_size):  # Débloquer les Tiles dans les nouvelles lignes
		for x in range(new_size):
			get_tile(x, y).locked = false

func expand_map():
	X_fences.position.z += 2*tileSize
	Z_fences.position.x += 2*tileSize
	
	unlock_new_tiles(current_size+2)
	
	current_size += 2
	current_fence += 1
	
	X_fences.get_node("fence" + str(current_fence)).visible = true
	Z_fences.get_node("fence" + str(current_fence)).visible = true
	
	if current_size == size:
		X_fences.queue_free()
		Z_fences.queue_free()

#@export var highlight : MeshInstance3D
#@export var size : int = 20
#@export var tileSize : float = 0.8
#
#var data : Array = []
#var groundData : Array = []
#var selectedPlant : Plant:
	#set(value):
		#if value != null:
			#update_zone_indicator(value.get_highlight_zones())
		#else:
			#update_zone_indicator([])
		#selectedPlant = value
#
#var tomato : PackedScene = preload("res://Plants/Scene/tomato.tscn")
#
##### Gestion des secteurs ####$
#var map_size : int = 5


#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#highlight.mesh.size = Vector2(tileSize, tileSize)
	#init_data()
	#create_ground()
	#create_plant(1,1,load("res://Plants/Scene/well.tscn"))
#
#func _physics_process(delta):
	#var mouseTile = get_mouse_tile_position()
	#mouseTile = Vector3(floor(mouseTile.x), 0.001, floor(mouseTile.z))
	#highlight.position = mouseTile * tileSize + Vector3(tileSize/2, 0, tileSize/2)
	#if is_tile_free(mouseTile.x, mouseTile.z):
		#highlight.material_override.albedo_color = Color(0.8,0.8,0.8,0.4)
		#for h in highlightArray:
			#if is_inside((highlight.position.x + h.position.x)/tileSize, (highlight.position.z + h.position.z)/tileSize):
				#h.mesh.material.albedo_color = Color(0.082, 0.957, 0.282, 0.4)
			#else:
				#h.mesh.material.albedo_color = Color(0.2, 0.2, 0.2, 0.4)
	#else:
		#highlight.material_override.albedo_color = Color(1,0,0,0.4)
		#for h in highlightArray:
			#h.mesh.material.albedo_color = Color(0.2, 0.2, 0.2, 0.4)
#
#
#func _unhandled_input(event):
	#if event is InputEventMouseMotion:
		#if event.pressure == 1:
			#before_harvest()
	#if event.is_action_pressed("click"):
		#before_harvest()
		#
#func before_harvest():
	#var intersection_point = get_mouse_tile_position()
	#var plant : Plant = get_tile_plant(intersection_point.x, intersection_point.z)
	#
	#if plant != null and plant.isPlant and plant.stage == plant.stages[-1]:
		#harvest_plant(plant)
#
#func harvest_plant(plant : Plant):
	#Global.sun += plant.sunProd * plant.scoreRate
	#Global.gold += plant.income * plant.incomeRate
	#plant.reset_growth()
#
#func create_plant(x:int, y:int, plantScene:PackedScene):
	#if (is_tile_free(x, y)):
		#if (x >= 0 && x < current_size && y >= 0 && y < current_size):
			#var plant : Plant = plantScene.instantiate()
			#plant.pos = Vector2(x, y)
			#plant.position = Vector3(plant.pos.x*tileSize + tileSize/2, 0, plant.pos.y*tileSize + tileSize/2)
			#plant.grid = self
			#data[x][y] = plant
			#groundData[x][y].plant = plant
			#add_child(plant)
		#else:
			#push_warning("tried to add plant outside of grid")
	#else:
		#push_warning("a plant is already here")
#
#func init_data():
	#for i in range(size):
		#data.append([])
		#groundData.append([])
		#for j in range(size):
			#data[i].append(null)
			#groundData[i].append(null)
#
#func get_mouse_tile_position():
	#var mouse_pos = get_viewport().get_mouse_position()
	#var camera = get_viewport().get_camera_3d()
	#var ray_origin = camera.project_ray_origin(mouse_pos)
	#var ray_direction = camera.project_ray_normal(mouse_pos)
	#var t = -ray_origin.y / ray_direction.y
	#var intersection_point = ray_origin + t * ray_direction
	#return intersection_point / tileSize
#
#func is_tile_free(x,y) -> bool:
	#if (x >= 0 && x < current_size && y >= 0 && y < current_size):
		#return !data[x][y] is Plant
	#else: return false
#
#func get_tile_plant(x,y) -> Plant:
	#if (x >= 0 && x < current_size && y >= 0 && y < current_size):
		#return data[x][y]
	#else:
		#return null
#
#func create_ground():
	#var groundScene : PackedScene = load("res://Plants/Grounds/ground_tile.tscn")
	#for x in range(size):
		#for y in range(size):
			#var g : MeshInstance3D = groundScene.instantiate()
			#g.position = Vector3(x*tileSize + tileSize/2, 0, y*tileSize + tileSize/2)
			#
			#if ( (x+y) % 2 == 0 ):
				#g.mesh.material.albedo_color -= Color(.025,.025,.025, 0)
			#
			#add_child(g)
			#groundData[x][y] = g
#
#@onready var yellowHighlightScene = preload("res://Plants/Grounds/yellow_highlight.tscn")
#var highlightArray : Array[MeshInstance3D]
#func update_zone_indicator(array: Array[Vector2]):
	#highlightArray.clear()
	#for child in highlight.get_children():
		#child.queue_free()
	#
	#for v in array:
		#var h : MeshInstance3D = yellowHighlightScene.instantiate()
		#h.position = Vector3(tileSize*v.x, 0, tileSize*v.y)
		#highlightArray.append(h)
		#highlight.add_child(h)
#
#func is_inside(x,y):
	#return (x >= 0 && x < current_size && y >= 0 && y < current_size)

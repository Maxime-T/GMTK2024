extends Node3D

class_name PlantGrid

@export var highlight : MeshInstance3D
@export var size : int = 20
var current_size : int = 4
@export var tileSize : float = 0.8

var data : Array = []
var groundData : Array = []
var selectedPlant : Plant:
	set(value):
		if value != null:
			update_zone_indicator(value.get_highlight_zones())
		else:
			update_zone_indicator([])
		selectedPlant = value

var tomato : PackedScene = preload("res://Plants/Scene/tomato.tscn")

#### Gestion des secteurs ####$
var map_size : int = 5
var current_fence : int = 4
@export var X_fences : Node3D
@export var Z_fences : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	highlight.mesh.size = Vector2(tileSize, tileSize)
	init_data()
	create_ground()
	create_plant(1,1,load("res://Plants/Scene/well.tscn"))

func _physics_process(delta):
	var mouseTile = get_mouse_tile_position()
	mouseTile = Vector3(floor(mouseTile.x), 0.001, floor(mouseTile.z))
	highlight.position = mouseTile * tileSize + Vector3(tileSize/2, 0, tileSize/2)
	if is_tile_free(mouseTile.x, mouseTile.z):
		highlight.material_override.albedo_color = Color(0.8,0.8,0.8,0.4)
		for h in highlightArray:
			if is_inside((highlight.position.x + h.position.x)/tileSize, (highlight.position.z + h.position.z)/tileSize):
				h.mesh.material.albedo_color = Color(0.082, 0.957, 0.282, 0.4)
			else:
				h.mesh.material.albedo_color = Color(0.2, 0.2, 0.2, 0.4)
	else:
		highlight.material_override.albedo_color = Color(1,0,0,0.4)
		for h in highlightArray:
			h.mesh.material.albedo_color = Color(0.2, 0.2, 0.2, 0.4)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.pressure == 1:
			before_harvest()
	if event.is_action_pressed("click"):
		before_harvest()
		
func before_harvest():
	var intersection_point = get_mouse_tile_position()
	var plant : Plant = get_tile_plant(intersection_point.x, intersection_point.z)
	
	if plant != null and plant.isPlant and plant.stage == plant.stages[-1]:
		harvest_plant(plant)

func harvest_plant(plant : Plant):
	Global.sun += plant.sunProd * plant.scoreRate
	Global.gold += plant.income * plant.incomeRate
	plant.reset_growth()

func create_plant(x:int, y:int, plantScene:PackedScene):
	if (is_tile_free(x, y)):
		if (x >= 0 && x < current_size && y >= 0 && y < current_size):
			var plant : Plant = plantScene.instantiate()
			plant.pos = Vector2(x, y)
			plant.position = Vector3(plant.pos.x*tileSize + tileSize/2, 0, plant.pos.y*tileSize + tileSize/2)
			plant.grid = self
			data[x][y] = plant
			groundData[x][y].plant = plant
			add_child(plant)
		else:
			push_warning("tried to add plant outside of grid")
	else:
		push_warning("a plant is already here")

func init_data():
	for i in range(size):
		data.append([])
		groundData.append([])
		for j in range(size):
			data[i].append(null)
			groundData[i].append(null)

func get_mouse_tile_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var t = -ray_origin.y / ray_direction.y
	var intersection_point = ray_origin + t * ray_direction
	return intersection_point / tileSize

func is_tile_free(x,y) -> bool:
	if (x >= 0 && x < current_size && y >= 0 && y < current_size):
		return !data[x][y] is Plant
	else: return false

func get_tile_plant(x,y) -> Plant:
	if (x >= 0 && x < current_size && y >= 0 && y < current_size):
		return data[x][y]
	else:
		return null

func create_ground():
	var groundScene : PackedScene = load("res://Plants/Grounds/ground_tile.tscn")
	for x in range(size):
		for y in range(size):
			var g : MeshInstance3D = groundScene.instantiate()
			g.position = Vector3(x*tileSize + tileSize/2, 0, y*tileSize + tileSize/2)
			
			if ( (x+y) % 2 == 0 ):
				g.mesh.material.albedo_color -= Color(.025,.025,.025, 0)
			
			add_child(g)
			groundData[x][y] = g

@onready var yellowHighlightScene = preload("res://Plants/Grounds/yellow_highlight.tscn")
var highlightArray : Array[MeshInstance3D]
func update_zone_indicator(array: Array[Vector2]):
	highlightArray.clear()
	for child in highlight.get_children():
		child.queue_free()
	
	for v in array:
		var h : MeshInstance3D = yellowHighlightScene.instantiate()
		h.position = Vector3(tileSize*v.x, 0, tileSize*v.y)
		highlightArray.append(h)
		highlight.add_child(h)

func is_inside(x,y):
	return (x >= 0 && x < current_size && y >= 0 && y < current_size)

func expand_map():
	X_fences.position.z += 2*tileSize
	Z_fences.position.x += 2*tileSize
	current_size += 2
	X_fences.get_node("fence" + str(current_fence)).visible = true
	Z_fences.get_node("fence" + str(current_fence)).visible = true
	current_fence += 1
	
	if current_fence == 8:
		X_fences.get_node("fence" + str(current_fence)).visible = true
		Z_fences.get_node("fence" + str(current_fence)).visible = true
		current_fence += 1
	
	if current_size == size:
		X_fences.queue_free()
		Z_fences.queue_free()



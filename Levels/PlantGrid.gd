extends Node3D

class_name PlantGrid

@export var highlight : MeshInstance3D

@export var size : int = 16
@export var tileSize : float = 0.8

var data : Array = []
var groundData : Array = []

var tomato : PackedScene = preload("res://Plants/Scene/tomato.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	highlight.mesh.size = Vector2(tileSize,tileSize)
	init_data()
	create_ground()
	create_plant(0, 0, tomato)

func _physics_process(delta):
	var mouseTile = get_mouse_tile_position()
	mouseTile = Vector3(floor(mouseTile.x), 0.001, floor(mouseTile.z))
	highlight.position = mouseTile * tileSize + Vector3(tileSize/2, 0, tileSize/2)
	if is_tile_free(mouseTile.x, mouseTile.z):
		highlight.material_override.albedo_color = Color(0.8,0.8,0.8,0.5)
	else:
		highlight.material_override.albedo_color = Color(1,0,0,0.5)


func _input(event):
	if event.is_action_pressed("click"):
		var intersection_point = get_mouse_tile_position()
		create_plant(intersection_point.x, intersection_point.z, tomato)


func create_plant(x:int, y:int, plantScene:PackedScene):
	if (is_tile_free(x, y)):
		if (x >= 0 && x < size && y >= 0 && y < size):
			var plant : Plant = plantScene.instantiate()
			plant.pos = Vector2(x*tileSize, y*tileSize)
			plant.position = Vector3(plant.pos.x + tileSize/2, 0, plant.pos.y + tileSize/2)
			data[x][y] = plant
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
	if (x >= 0 && x < size && y >= 0 && y < size):
		return !data[x][y] is Plant
	else: return false

func create_ground():
	var groundScene : PackedScene = load("res://Plants/Grounds/ground_tile.tscn")
	for x in range(size):
		for y in range(size):
			var g : MeshInstance3D = groundScene.instantiate()
			g.position = Vector3(x*tileSize + tileSize/2, 0, y*tileSize + tileSize/2)
			add_child(g)




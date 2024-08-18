extends Node3D

class_name PlantGrid

@export var size : int = 16
@export var tileSize : float = 0.8

var data : Array = []

var tomato : PackedScene = preload("res://Plants/tomato.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_data()
	create_plant(0, 0, tomato)

func _input(event):
	if event.is_action_pressed("click"):
		var intersection_point = get_mouse_tile_position()
		create_plant(intersection_point.x, intersection_point.z, tomato)


func create_plant(x:int, y:int, plantScene:PackedScene):
	
	if (!data[x][y] is Plant):
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
		for j in range(size):
			data[i].append([])

func get_mouse_tile_position():
	var mouse_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	var t = -ray_origin.y / ray_direction.y
	var intersection_point = ray_origin + t * ray_direction
	return intersection_point / tileSize

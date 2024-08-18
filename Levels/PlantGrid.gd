extends Node3D

class_name PlantGrid

@export var size : int = 16

var data : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	init_data()
	create_plant(0, 0, load("res://Plants/tomato.tscn"))

func _input(event):
	if event.is_action_pressed("click"):
		var intersection_point = get_mouse_tile_position()
		create_plant(floor(intersection_point.x), floor(intersection_point.z), load("res://Plants/tomato.tscn"))


func create_plant(x:int, y:int, plantScene:PackedScene):
	
	if (!data[x][y] is Plant):
		if (x >= 0 && x < size && y >= 0 && y < size):
			var plant : Plant = plantScene.instantiate()
			plant.pos = Vector2(x,y)
			plant.position = Vector3(x + 0.5, 0, y + 0.5)
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
	return intersection_point

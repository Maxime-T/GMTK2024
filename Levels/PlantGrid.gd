extends Node3D

class_name PlantGrid

@export var size : int = 16

var data : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	initData()
	createPlant(0, 0, load("res://Plants/tomato.tscn"))

func _input(event):
	if event.is_action_pressed("click"):
		var mouse_pos = get_viewport().get_mouse_position()
		var camera = get_viewport().get_camera_3d()
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_direction = camera.project_ray_normal(mouse_pos)
		var t = -ray_origin.y / ray_direction.y
		var intersection_point = ray_origin + t * ray_direction
		print(intersection_point)
		createPlant(floor(intersection_point.x), floor(intersection_point.z), load("res://Plants/tomato.tscn"))


func createPlant(x:int, y:int, plantScene:PackedScene):
	var plant : Plant = plantScene.instantiate()
	plant.pos = Vector2(x,y)
	plant.position = Vector3(x + 0.5, 0, y + 0.5)
	data[x][y] = plant
	add_child(plant)

func initData():
	for i in range(size):
		data.append([])
		for j in range(size):
			data[i].append([])

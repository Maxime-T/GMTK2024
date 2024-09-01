extends MeshInstance3D
class_name GroundTile

var plant : Plant = null:
	set(value):
		if value != null:
			plant = value
			plant.connect("ready", updatePlantModifiers)

func updatePlantModifiers():
	plant.growRate = growRate
	plant.incomeRate = incomeRate
	plant.scoreRate = scoreRate
	plant.water = water
	

var growRate : float = 1 :
	set(value):
		growRate = value
		if plant != null:
			plant.growRate = value
var incomeRate : float = 1:
	set(value):
		incomeRate = value
		if plant != null:
			plant.incomeRate = value
var scoreRate : float = 1:
	set(value):
		scoreRate = value
		if plant != null:
			plant.scoreRate = value

var water : int = 0:
	set(value):
		water = value
		if plant != null:
			plant.water = value


@onready var baseColor : Color = mesh.surface_get_material(0).albedo_color

func set_highlight(color : Color):
	mesh.surface_get_material(0).albedo_color = baseColor + color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

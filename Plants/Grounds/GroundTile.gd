extends MeshInstance3D
class_name GroundTile



@onready var baseColor : Color = mesh.surface_get_material(0).albedo_color

func set_highlight(color : Color):
	mesh.surface_get_material(0).albedo_color = baseColor + color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

extends MeshInstance3D
class_name GroundTile
@onready var baseColor : Color = mesh.surface_get_material(0).albedo_color

var nextColor : Color

func set_highlight(color : Color):
	nextColor = baseColor + color

func _physics_process(delta: float) -> void:
	mesh.surface_get_material(0).albedo_color = nextColor
	nextColor = baseColor

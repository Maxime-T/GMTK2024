extends GridComponent
class_name Ground

var baseColor : Color
var nextColor : Color

func _ready() -> void:
	super()
	baseColor = meshInstance.mesh.surface_get_material(0).albedo_color

func add_modifiers():
	pass

func set_highlight(color : Color):
	nextColor = baseColor + color

func _physics_process(_delta: float) -> void:
	meshInstance.mesh.surface_get_material(0).albedo_color = nextColor
	nextColor = baseColor

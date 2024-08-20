extends Node3D
var basePosition : Vector3
var baseRotation : Vector3
var ratio : float = 0.

func _ready():
	basePosition = position
	baseRotation = rotation
	Global.connect("G_S_P_changed", update)

func update():
	ratio = clamp(Global.sun / 4600, 0, 1)
	var tween : Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position:y",basePosition.y + (ratio) * 12.307, 1.)
	#tween.tween_property(self, "rotation:y",baseRotation.y + (ratio) * -2*PI * 8, 1.)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

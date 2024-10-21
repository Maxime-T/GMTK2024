extends GridComponent
class_name Obstacle

@export var final_scale : float = 1

func _ready() -> void:
	spawning()


func spawning():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector3.ONE * final_scale, 0.3).from(Vector3.ONE*0.2)

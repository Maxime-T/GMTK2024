extends Control
class_name Card


var confirmed : bool:
	set(val):
		if not val:
			custom_minimum_size = base_size
		confirmed = val
var base_size : Vector2


func _ready():
	base_size = custom_minimum_size

		
func _input(event):
	if event.is_action_pressed("right click"):
		release_focus()
		confirmed = false
	##Suprimer seulement si elle est bien placé
	if event.is_action_pressed("click") and confirmed:
		queue_free()

func _on_mouse_entered():
	if confirmed:
		return
	custom_minimum_size = base_size * 1.5


func _on_mouse_exited():
	if confirmed:
		return
	custom_minimum_size = base_size


func _on_focus_entered():
	confirmed = true


func _on_focus_exited():
	confirmed = false

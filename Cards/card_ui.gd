extends Control
class_name Card

var scale_size = 1.3

var confirmed : bool:
	set(val):
		if not val:
			scale = Vector2(1,1)
		confirmed = val
		
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
	scale = Vector2(scale_size,scale_size)


func _on_mouse_exited():
	if confirmed:
		return
	scale = Vector2(1,1)


func _on_focus_entered():
	confirmed = true


func _on_focus_exited():
	confirmed = false

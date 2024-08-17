extends Camera3D

@export var SPEED : float = 5.
@export var ACCELERATION : float = 10.

@export var ROTATESPEED : float = 1

@export var parent : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var realDirection : Vector2

func _process(delta):
	var inputDirection = Input.get_vector("Left", "Right", "Up", "Down")
	realDirection = realDirection.move_toward(inputDirection, ACCELERATION * delta)
	
	var velocity = transform.basis.x * realDirection.x
	velocity -= transform.basis.y * realDirection.y
	parent.translate(velocity * SPEED * delta)
	
	parent.rotation.y += Input.get_axis("Rotate_Clockwise", "Rotate_CounterClockwise") * ROTATESPEED * delta





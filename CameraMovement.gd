extends Camera3D

@export var SPEED : float = 8.
@export var ACCELERATION : float = 10.

@export var ROTATESPEED : float = 2

@export var parent : Node3D
@export var plantGrid : PlantGrid

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var realDirection : Vector2

func _process(delta):
	var inputDirection = Input.get_vector("Left", "Right", "Up", "Down")
	realDirection = realDirection.move_toward(inputDirection, ACCELERATION * delta)
	
	var velocity = transform.basis.x * realDirection.x
	velocity += project_vector_onto_plane(transform.basis.z, Vector3(0,1,0)).normalized() * realDirection.y
	parent.translate(velocity * SPEED * (clamp(size/5.,0.8,2.)) * delta)
	#parent.position = parent.position.clamp(Vector3(-1,-1,-1), Vector3.ONE * plantGrid.current_size * plantGrid.tileSize)
	
	parent.rotation.y += Input.get_axis("Rotate_Clockwise", "Rotate_CounterClockwise") * ROTATESPEED * delta
	#parent.rotation.y = move_toward(parent.rotation.y, 0, delta)


func _input(event):
	if event.is_action_pressed("ZoomIn"):
		size -= 0.5
		size = clamp(size, 2, 10)
	
	if event.is_action_pressed("ZoomOut"):
		size += 0.5
		size = clamp(size, 2, 10)

func project_vector_onto_plane(vector: Vector3, plane_normal: Vector3) -> Vector3:
	# Normalize the plane normal to ensure it has a length of 1
	plane_normal = plane_normal.normalized()

	# Calculate the projection of the vector onto the plane normal
	var projection_on_normal = vector.dot(plane_normal)
	
	# Subtract the projection from the original vector to get the component parallel to the plane
	var vector_on_plane = vector - plane_normal * projection_on_normal
	
	return vector_on_plane


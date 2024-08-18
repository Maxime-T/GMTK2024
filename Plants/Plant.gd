extends Node3D
class_name Plant

@export var plantName : String

@export_group("Costs")
@export var sunCost : int = 0:
	set(val):
		Global.sun += sunCost - val
		sunCost = val

@export var waterCost : int = 0
@export var pollutionGeneration : float = 0

@export_group("Production")
@export var goldValue : float = 0
@export var timeToGrow : float = 60 #en seconde
@export var growRate : float = 1

var GrowTimer: Timer
var scaleFactor : float = 1:
	set(val):
		scale = Vector3(val, val, val)
		scaleFactor = val
	
var pos : Vector2


func _ready():
	GrowTimer = Timer.new()
	add_child(GrowTimer)
	GrowTimer.one_shot = true
	GrowTimer.timeout.connect(_on_growtimer_timeout)
	
	start_to_grow()


func _process(delta):
	pass


func start_to_grow():
	GrowTimer.wait_time = timeToGrow / growRate
	GrowTimer.start()
	
func _on_growtimer_timeout():
	Global.gold += goldValue * scaleFactor
	start_to_grow()

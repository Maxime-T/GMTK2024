extends Node
class_name Modifier

var origin : Node
var type : TYPE
var value : float

func _init(_origin : Node, _type : TYPE, _value : float) -> void:
	origin = _origin
	type = _type
	value = _value

enum TYPE {
	BASE,
	MULT,
	REAL_MULT,
	FLAT
}

func _to_string() -> String:
	return str(origin) + " " + str(type) + " " + str(value)

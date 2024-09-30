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
	FLAT
}

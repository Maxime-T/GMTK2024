@tool
extends Resource
class_name ModifiableValue

signal modified(newValue)

@export var baseValue : float
var setFunction : Callable

func _init(_baseValue : float = 0., _setFunction : Callable = func(_value):null) -> void:
	baseValue = _baseValue
	setFunction = _setFunction

var modifiers : Array[Modifier]

func calculate_value() -> float:
	var base : float = baseValue
	for baseMod in modifiers:
		if baseMod.type == Modifier.TYPE.BASE:
			base += baseMod.value
	
	var mult : float = 1.
	for multMod in modifiers:
		if multMod.type == Modifier.TYPE.MULT:
			mult += multMod.value
	
	var flat : float = 0.
	for flatMod in modifiers:
		if flatMod.type == Modifier.TYPE.FLAT:
			flat += flatMod.value
	return max(max(base*mult,0) + flat,0)

func emit_value() -> void:
	var value : float = calculate_value()
	setFunction.call(value)
	modified.emit(value)

func remove_modifier(mod : Modifier):
	modifiers.erase(mod)
	emit_value()

func add_modifier(origin : Node, type : Modifier.TYPE, value : float):
	var mod = Modifier.new(origin, type, value)
	modifiers.append(mod)
	emit_value()
	
	if !origin.tree_exiting.is_connected(removeAllModifersFromOrigin):
		origin.tree_exiting.connect(removeAllModifersFromOrigin.bind(origin))

func removeAllModifersFromOrigin(origin : Node):
	for mod in modifiers:
		if mod.origin == origin:
			modifiers.erase(mod)
	emit_value()

func removeAllModifiers():
	modifiers.clear()
	emit_value()

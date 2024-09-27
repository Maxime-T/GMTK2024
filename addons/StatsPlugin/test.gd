extends EditorInspectorPlugin

func _can_handle(object: Object) -> bool:
	return object is Stats

func _parse_property(object: Object, type: Variant.Type, name: String, hint_type: PropertyHint, hint_string: String, usage_flags: int, wide: bool) -> bool:
	
	var label := Label.new()
	label.text = name
	add_custom_control(label)
	
	var control := EditorSpinSlider.new()
	control.step = 0.1
	control.value = object.get(name).baseValue
	control.value_changed.connect(_value_changed.bind(object.get(name)))
	add_property_editor(name, control, false, name)
	
	return true

func _value_changed(newValue : float, mod : Object):
	mod.baseValue = newValue

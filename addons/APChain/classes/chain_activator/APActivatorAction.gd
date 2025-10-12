@tool
extends APActivator
class_name APActivatorAction

## Активирует цепочку когда нажато [InputEventAction]

@export_storage var _action:String = ""
@export_tool_button("Rename node to action name") var rename = func():
	assert(not _action.is_empty(), "action is empty, %s"%[get_path()])
	name = _action

func _get_property_list():
	var actions = []
	for prop in ProjectSettings.get_property_list():
		var prop_name:String = prop.get("name", "")
		if prop_name.begins_with('input/'):
			prop_name = prop_name.replace('input/', '') 
			prop_name = prop_name.substr(0, prop_name.find("."))
			if not actions.has(prop_name):
				actions.append(prop_name)
	
	var hint_string = ",".join(actions)
	
	var properties = []
	properties.append({
		"name": "action",
		"type": TYPE_STRING_NAME,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": hint_string
	})
	return properties

func _set(property: StringName, value: Variant) -> bool:
	match property:
		"action": _action = value
		_: return false
	return true

func _get(property: StringName) -> Variant:
	match property:
		"action": return _action
		_: return null

func _change_enable():
	set_process_input(enable)

func _ready() -> void:
	if not Engine.is_editor_hint():
		assert(not _action.is_empty(), "action is empty, %s"%[get_path()])
		pass
	set_process_input(enable)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed(_action):
		activated.emit()

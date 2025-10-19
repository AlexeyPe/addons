@tool
extends AudioStreamPlayer
class_name AudioStreamPlayerVaRes

## Какой [VarRes] будет просшуливаться на сигналы
@export var vares:VarRes : 
	set(new):
		vares = new
		notify_property_list_changed()
@export_tool_button("Rename self node") var _rename = rename_self
@export_storage var vares_signal:String
# vares is VaRBool
@export_storage var set_bool_after_signal:bool = false
@export_storage var new_bool_after_signal:bool = false

func rename_self():
	if !vares:
		printerr("AudioStreamPlayerVaRes, vares is null, ", get_path())
		return
	if vares.resource_name.is_empty():
		printerr("AudioStreamPlayerVaRes, vares resource_name is null, ", get_path())
		return
	name = "%s=%s"%[vares.resource_name, vares_signal]

func _get_property_list():
	var properties = []
	if vares != null:
		var signals:Array[String]
		for _signal in vares.get_signal_list():
			signals.append(_signal.name)
		if vares_signal.is_empty():
			vares_signal = signals[0]
		elif !vares.has_signal(vares_signal):
			vares_signal = signals[0]
		properties.append({
			"name": "vares_signal",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": ",".join(signals),
		})
	if vares is VaRBool:
		properties.append({
			"name": "set_bool_after_signal",
			"type": TYPE_BOOL,
		})
		properties.append({
			"name": "new_bool_after_signal",
			"type": TYPE_BOOL,
		})
	return properties

func _set(property: StringName, value: Variant) -> bool:
	match property:
		"vares_signal": vares_signal = value
		_: return false
	return true

func _get(property: StringName) -> Variant:
	match property:
		"vares_signal": return vares_signal
		_: return null

func _property_can_revert(property: StringName) -> bool:
	match property:
		"vares_signal": return true
		_: return false

func _property_get_revert(property: StringName) -> Variant:
	match property:
		"vares_signal": return vares.get_signal_list()[0].name
		_: return null

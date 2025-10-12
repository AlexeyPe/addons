@tool
extends APActivator
class_name APActivatorResource

## Активирует цепочку когда ресурс выдаст сигнал

@export_storage var _signal:String = ""
@export_tool_button("Rename node to signal name") var rename = func():
	if resource == null: name = "err_res_null"
	elif _signal.is_empty(): name = "err_signal_empty" 
	elif resource.resource_name.is_empty(): name = _signal
	else: name = "%s=%s"%[resource.resource_name, _signal]
@export var resource:Resource :
	set(new):
		resource = new
		notify_property_list_changed()
@export var call_init:bool = false

func _get_property_list():
	if not resource: return []
	var signals = []
	for _signal in resource.get_signal_list():
		signals.append(_signal.name)
	
	var hint_signals = ",".join(signals)
	
	var properties = []
	properties.append({
		"name": "signal",
		"type": TYPE_STRING_NAME,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": hint_signals
	})
	return properties

func _set(property: StringName, value: Variant) -> bool:
	match property:
		"signal": _signal = value
		_: return false
	return true

func _get(property: StringName) -> Variant:
	match property:
		"signal": return _signal
		_: return null

func _change_enable():
	if not resource: return
	if enable:
		if resource.has_signal(_signal) and\
			not resource.is_connected(_signal, emit_activated):
			resource.connect(_signal, emit_activated)
	else:
		if resource.has_signal(_signal) and\
			resource.is_connected(_signal, emit_activated):
			resource.disconnect(_signal, emit_activated)

func _ready() -> void:
	_change_enable()
	if call_init:
		resource._init()
	if not Engine.is_editor_hint():
		assert(resource != null, "resource is null, %s"%[self])

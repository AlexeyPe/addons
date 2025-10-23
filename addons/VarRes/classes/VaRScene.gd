@tool
extends VarRes
class_name VaRScene

@export var value:PackedScene : 
	set(new):
		value = new
		emit_changed()

func is_empty() -> bool:
	return value == null

func paste(data:Variant):
	if data is VaRScene:
		value = data.value
	elif data is PackedScene:
		value = data
		print("%s paste %s, is_empty:%s"%[
			resource_name,
			data,
			is_empty()
		])

func _to_string() -> String:
	if value:
		return "VaRScene_%s:%s"%[resource_name, value.get_state().get_node_name(0)]
	else:
		return "VaRScene_%s:null"%[resource_name]

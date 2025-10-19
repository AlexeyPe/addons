@tool
extends VarRes
class_name VaRScene

@export var value:PackedScene : 
	set(new):
		value = new
		emit_changed()

func is_empty() -> bool:
	return value == null

func paste(vares:VarRes):
	if vares is VaRScene:
		value = vares.value

func _to_string() -> String:
	return "VaRScene:%s"%[value.get_state().get_node_name(0)]

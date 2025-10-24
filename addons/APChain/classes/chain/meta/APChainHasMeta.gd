@tool
extends APChain
class_name APChainHasMeta

signal has_meta_true
signal has_meta_false

@export var meta_name:String
@export var set_chain_num_a:APChainIfNum
@export_tool_button("Rename self node") var _rename = _rename_self

func _rename_self():
	if meta_name.is_empty():
		printerr("APChainHasMeta(%s) meta_name is empty"%[name])
	else:
		name = "HasMeta=%s"%[meta_name]

func _execute(...args:Array) -> void:
	if not meta_name.is_empty():
		if node_emitter.has_meta(meta_name):
			has_meta_true.emit()
		else:
			has_meta_false.emit()

@tool
extends APChain
class_name APChainHasMeta

signal has_meta_true
signal has_meta_false

@export var meta_name:String
@export var meta_owner:Node
@export var meta_value_paste:VarRes
## Оставить пустым что бы пропустить.[br]
## Вставит metadata из meta_owner в этот ресурс.
@export var meta_paste_to_vares:VarRes
@export_tool_button("Rename self node") var _rename = _rename_self

func _rename_self():
	if meta_name.is_empty():
		printerr("APChainHasMeta(%s) meta_name is empty"%[name])
	else:
		name = "HasMeta=%s"%[meta_name]

func _execute(...args:Array) -> void:
	if not meta_name.is_empty():
		if meta_owner.has_meta(meta_name):
			if meta_paste_to_vares:
				meta_paste_to_vares.paste(meta_owner.get_meta(meta_name))
			if meta_value_paste:
				var data = meta_owner.get_meta(meta_name)
				if data is VarRes:
					data.paste(meta_value_paste)
			has_meta_true.emit()
		else:
			has_meta_false.emit()

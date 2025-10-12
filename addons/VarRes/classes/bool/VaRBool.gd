@tool
extends VarRes
class_name VaRBool

## Вылаётся когда value изменен на true 
signal now_true()
signal now_false()

@export var value:bool = false : 
	set(new):
		value = new
		check()
		emit_changed()
@export_storage var storage_value:bool

func _to_string() -> String:
	return "%s %s"%[resource_path.get_basename().get_file(), value]

func get_value() -> bool: return value

func _init() -> void:
	check()

func check():
	if value: now_true.emit()
	else: now_false.emit()

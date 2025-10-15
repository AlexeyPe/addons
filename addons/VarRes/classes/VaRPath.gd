extends VarRes
class_name VaRPath

## Абсолютный путь до ноды
@export_storage var path:NodePath : 
	set(new):
		path = new
		emit_changed()

func clear():
	path = ""

func _to_string() -> String:
	return "VaRPath:%s"%[path]

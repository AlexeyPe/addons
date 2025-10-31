@tool
extends VarRes
class_name VaRVector2

@export var value:Vector2 = Vector2.ZERO

func get_value() -> Vector2:
	return value

func set_value(new: Vector2):
	value = new
	emit_changed()

func paste(data:Variant):
	if data is Vector2:
		value = data
	elif data is VaRVector2:
		value = data.get_value()

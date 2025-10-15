@tool
extends VaRNumber
class_name VaRInt

@export var min_value_res:VaRInt : set = set_min_value_res
@export var max_value_res:VaRInt : set = set_max_value_res
@export var value:int = 42 : set = set_value

func is_max() -> bool:
	return value == get_max_value()

func _to_string() -> String:
	return "%s %s"%[resource_path.get_basename().get_file(), value]

func on_update_min_value_res(): emit_changed()
func set_min_value_res(new:VaRInt):
	if min_value_res and min_value_res.changed.is_connected(on_update_min_value_res):
		min_value_res.changed.disconnect(on_update_min_value_res)
	min_value_res = new
	if min_value_res:
		min_value_res.changed.connect(on_update_min_value_res)
	emit_changed()

func on_update_max_value_res(): emit_changed()
func set_max_value_res(new:VaRInt):
	if max_value_res and max_value_res.changed.is_connected(on_update_max_value_res):
		max_value_res.changed.disconnect(on_update_max_value_res)
	max_value_res = new
	if max_value_res:
		max_value_res.changed.connect(on_update_max_value_res)
	emit_changed()

func get_min_value() -> int:
	# Minimum negative integer value for a signed 64-bit integer
	var _min_value:int = -9223372036854775808
	if min_value_res != null:
		_min_value = min_value_res.value
	return _min_value
func get_max_value() -> int:
	# Maximum positive integer value for a signed 64-bit integer
	var _max_value:int = 9223372036854775807
	if max_value_res != null:
		_max_value = max_value_res.value
	return _max_value

func get_value() -> int: return value
func set_value(new: int):
	if value == new: return
	if new >= get_min_value() and new <= get_max_value():
		if value < new:
			value = new
			emit_changed()
			now_more.emit()
		else:
			value = new
			emit_changed()
			now_less.emit()

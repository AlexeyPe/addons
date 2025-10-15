@tool
extends VaRNumber
class_name VaRFloat

@export var min_value_res:VaRFloat : set = set_min_value_res
@export var max_value_res:VaRFloat : set = set_max_value_res
@export var value:float = 42.0 : set = set_value

func is_max() -> bool:
	return value == get_max_value()

func _to_string() -> String:
	return "%s %.3f"%[resource_path.get_basename().get_file(), value]

func _init(value:float = 42) -> void:
	self.value = value

func on_update_min_value_res(): emit_changed()
func set_min_value_res(new:VaRFloat):
	if min_value_res and min_value_res.changed.is_connected(on_update_min_value_res):
		min_value_res.changed.disconnect(on_update_min_value_res)
	min_value_res = new
	if min_value_res:
		min_value_res.changed.connect(on_update_min_value_res)
	emit_changed()

func on_update_max_value_res(): emit_changed()
func set_max_value_res(new:VaRFloat):
	if max_value_res and max_value_res.changed.is_connected(on_update_max_value_res):
		max_value_res.changed.disconnect(on_update_max_value_res)
	max_value_res = new
	if max_value_res:
		max_value_res.changed.connect(on_update_max_value_res)
	emit_changed()

func get_min_value() -> float:
	# Minimum negative integer value for a signed 64-bit integer
	var _min_value:float = -1.79769e308
	if min_value_res != null:
		_min_value = min_value_res.value
	return _min_value
func get_max_value() -> float:
	# Maximum positive integer value for a signed 64-bit integer
	var _max_value:float = 1.79769e308
	if max_value_res != null:
		_max_value = max_value_res.value
	return _max_value

func get_value() -> float: return value
func set_value(new: float):
	if new >= get_min_value():
		if new <= get_max_value():
			value = new
			emit_changed()
		elif value != get_max_value(): 
			value = get_max_value()
			emit_changed()
	elif value != get_min_value():
		value = get_min_value()
		emit_changed()

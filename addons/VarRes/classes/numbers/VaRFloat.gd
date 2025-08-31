@tool
extends VaRNumber
class_name VaRFloat

@export var min_value:VaRFloat : get = get_min_value
@export var max_value:VaRFloat : get = get_max_value
@export var value:float = 42.0 : set = set_value

func get_min_value() -> VaRFloat: return min_value
func get_max_value() -> VaRFloat: return max_value

func get_value() -> float: return value
func set_value(new: float):
	# Minimum negative integer value for a signed 64-bit integer
	var _min_value:float = -1.79769e308
	# Maximum positive integer value for a signed 64-bit integer
	var _max_value:float = 1.79769e308
	
	if min_value != null:
		_min_value = min_value.value
	if max_value != null:
		_max_value = max_value.value
	
	if new >= _min_value and new <= _max_value:
		value = new

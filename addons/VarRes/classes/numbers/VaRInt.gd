@tool
extends VaRNumber
class_name VaRInt

@export var min_value:VaRInt : get = get_min_value
@export var max_value:VaRInt : get = get_max_value
@export var value:int = 42 : set = set_value

func get_min_value() -> VaRInt: return min_value
func get_max_value() -> VaRInt: return max_value

func get_value() -> int: return value
func set_value(new: int):
	# Minimum negative integer value for a signed 64-bit integer
	var _min_value:int = -9223372036854775808
	# Maximum positive integer value for a signed 64-bit integer
	var _max_value:int = 9223372036854775807
	
	if min_value != null:
		_min_value = min_value.value
	if max_value != null:
		_max_value = max_value.value
	
	if new >= _min_value and new <= _max_value:
		#print('set_value = new:',new)
		value = new
		emit_changed()

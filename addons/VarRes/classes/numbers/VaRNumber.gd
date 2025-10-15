@tool
@abstract
extends VaRValue
class_name VaRNumber

## TODO is_max для compute

signal now_more
signal now_less

func get_min_value() -> Variant: return null
func get_max_value() -> Variant: return null
func is_max() -> bool: return false

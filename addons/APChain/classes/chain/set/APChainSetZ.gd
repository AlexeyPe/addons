@tool
extends APChain
class_name APChainSetZ

@export var target:CanvasItem
@export var new_z_index:int

func _execute(...args:Array) -> void:
	if target:
		target.z_index = new_z_index
		#prints("set z:", target.z_index, "for target:", target)

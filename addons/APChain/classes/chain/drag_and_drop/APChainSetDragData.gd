@tool
extends APChain
class_name APChainSetDragData

@export var target:APDragDataControl
@export var set_data:APDragDataRes

func _execute(...args:Array) -> void:
	if target:
		target.drag_data = set_data
	pass

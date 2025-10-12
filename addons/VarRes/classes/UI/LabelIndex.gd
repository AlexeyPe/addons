@tool
extends Label
class_name LabelIndex

@export var target_node:Node : 
	set(new):
		target_node = new
		set_process(target_node != null)

func _ready() -> void:
	set_process(target_node != null)

func _process(delta: float) -> void:	
	text = str(target_node.get_index())

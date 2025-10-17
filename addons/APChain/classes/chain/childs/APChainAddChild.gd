@tool
extends APChain
class_name APChainAddChild

@export var target_parent:Node
@export var scene:VaRScene
@export var force_readable_name:bool = false

func _execute(...args:Array) -> void:
	execution_started.emit()
	var child = scene.value.instantiate()
	target_parent.add_child(child, force_readable_name)
	executed.emit()
	executed_good.emit()

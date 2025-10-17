@tool
extends APChain
class_name APChainDelChildsArr

@export var nodes:Array[Node]

func _execute(...args:Array) -> void:
	if Engine.is_editor_hint(): return
	execution_started.emit()
	for node in nodes:
		node.queue_free()
	executed.emit()
	executed_good.emit()

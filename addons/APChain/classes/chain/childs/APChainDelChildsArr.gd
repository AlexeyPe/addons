@tool
extends APChain
class_name APChainDelChildsArr

@export var nodes:Array[Node]

func _execute(...args:Array) -> void:
	execution_started.emit()
	for node in nodes:
		node.queue_free()
	executed.emit()
	executed_good.emit()

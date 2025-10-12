@tool
extends APChain
class_name APChainSetVisible

@export var nodes_visible_true:Array[Node]
@export var nodes_visible_false:Array[Node]

func _execute(...args:Array):
	#print("_execute SetVisible")
	execution_started.emit()
	for node in nodes_visible_true:
		node.visible = true
	for node in nodes_visible_false:
		node.visible = false
	executed.emit()
	executed_good.emit()

func _ready():
	super._ready()

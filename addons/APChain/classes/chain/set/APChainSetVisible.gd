@tool
extends APChain
class_name APChainSetVisible

@export var nodes_visible_true:Array[Node]
@export var nodes_visible_false:Array[Node]
## Сколько нужно подождать перед тем как задавать visible
@export_range(0.0, 10.0, 0.2) var wait:float = 0.0

func _execute(...args:Array):
	#print("_execute SetVisible")
	execution_started.emit()
	if wait > 0.0:
		await get_tree().create_timer(wait).timeout
	for node in nodes_visible_true:
		node.visible = true
	for node in nodes_visible_false:
		node.visible = false
	executed.emit()
	executed_good.emit()

func _ready():
	super._ready()

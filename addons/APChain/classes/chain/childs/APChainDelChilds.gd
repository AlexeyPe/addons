@tool
extends APChain
class_name APChainDelChilds

@export var node_parent:Node
@export var delete_all:bool = false
@export_range(1, 99, 1) var quantity:int = 1

func _del(): 
	#prints("get_child_count:",node_parent.get_child_count(),"quantity:",quantity,"del:",del,"index:",index)
	if node_parent.get_child_count() == 0: return
	node_parent.get_child(
		randi_range(0, node_parent.get_child_count()-1)
	).queue_free()
	pass

func _execute(...args:Array) -> void:
	execution_started.emit()
	if delete_all:
		for child in node_parent.get_children():
			child.queue_free()
	else:
		for i in quantity:
			_del()
	executed.emit()
	executed_good.emit()

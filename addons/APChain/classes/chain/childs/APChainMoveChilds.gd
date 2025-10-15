@tool
extends APChain
class_name APChainMoveChilds

@export var parent:Node
@export var new_parent:Node
@export var with_metadata:Dictionary[String,Variant]
@export var new_metadata:Dictionary[String,Variant]

func _execute(...args:Array) -> void:
	execution_started.emit()
	if !parent or !new_parent:
		executed_failed.emit() 
		return
	var childs_move: Array[Node]
	for child in parent.get_children():
		for meta_name in with_metadata:
			if !child.has_meta(meta_name): 
				continue
			var meta = with_metadata[meta_name]
			if child.get_meta(meta_name) is VaRBool:
				if child.get_meta(meta_name).value != meta: 
					continue
				child.reparent(new_parent)
				childs_move.append(child)
				break
	for child in childs_move:
		for meta_name in new_metadata.keys():
			if child.get_meta(meta_name) is VaRBool:
				child.get_meta(meta_name).value = new_metadata[meta_name]
	executed.emit()
	executed_good.emit()

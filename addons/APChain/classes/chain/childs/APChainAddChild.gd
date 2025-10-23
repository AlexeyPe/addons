@tool
extends APChain
class_name APChainAddChild

signal added_child_exiting

@export var target_parent:Node
@export var scene:VaRScene
@export var force_readable_name:bool = false
@export var set_metadata:Dictionary[String, VarRes]

func _execute(...args:Array) -> void:
	execution_started.emit()
	if scene == null or scene.is_empty():
		if scene != null:
			print("APChainAddChild ", scene)
		executed.emit()
		executed_failed.emit()
		return
	var child:Node = scene.value.instantiate()
	print("APChainAddChild add ", child.name)
	target_parent.add_child(child, force_readable_name)
	if !child.tree_exiting.is_connected(added_child_exiting_emit):
		child.tree_exiting.connect(added_child_exiting_emit)
	if !set_metadata.is_empty():
		for key in set_metadata.keys():
			if !child.has_meta(key): continue
			var meta:Variant = child.get_meta(key)
			if meta is VarRes:
				meta.paste(set_metadata[key])
				continue
			printerr(
				"APChainAddChild(%s), child(%s) meta(%s) != VarRes"%[
					get_path(),
					child,
					key
				]
			)
	executed.emit()
	executed_good.emit()

func added_child_exiting_emit():
	added_child_exiting.emit()

@tool
extends APChain
class_name APChainAreaMeta

@export var meta_executions:Array[MetaCondition]

func _execute(...args:Array) -> void:
	if args.is_empty():
		executed_failed.emit()
		printerr("APChainArea, _execute(args = is empty), ",get_path())
		return
	elif args[0] is Node == false:
		printerr("APChainArea, _execute(args[0] != Node), ",get_path())
		return
	for meta in meta_executions:
		if !meta: continue
		meta.check(args[0])
	executed.emit()

@tool
extends APChain
class_name APChainSetCollisionEnable

@export var collision_disable:Array[CollisionShape2D]
@export var collision_enable:Array[CollisionShape2D]
@export_tool_button("Rename self node") var _rename = _rename_self 

func _rename_self():
	if get_signal_name():
		name = "SetCollision=%s"%[get_signal_name()]

func _execute(...args:Array) -> void:
	if Engine.is_editor_hint(): return
	execution_started.emit()
	for collision in collision_disable:
		#print("APChainSetCollisionEnable _execute disable")
		collision.set_deferred("disabled", true)
	for collision in collision_enable:
		#print("APChainSetCollisionEnable _execute enable")
		collision.set_deferred("disabled", false)
	executed.emit()
	executed_good.emit()

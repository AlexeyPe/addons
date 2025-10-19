@tool
extends APChain
class_name APChainSetCollisionEnable

@export var collision_disable:Array[CollisionShape2D]
@export var collision_enable:Array[CollisionShape2D]

func _execute(...args:Array) -> void:
	if Engine.is_editor_hint(): return
	execution_started.emit()
	for collision in collision_disable:
		collision.set_deferred("disabled", true)
		#collision.disabled = true
	for collision in collision_enable:
		collision.set_deferred("disabled", false)
		#collision.disabled = false
	executed.emit()
	executed_good.emit()

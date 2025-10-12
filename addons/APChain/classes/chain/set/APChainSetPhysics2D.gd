@tool
extends APChain
class_name APChainSetPhysics2D

## Нода для которой устанавливаются новые значения
@export var target_node:CollisionObject2D
@export_group("Collision")
## Нужно ли устанавливать значения для группы Collision
@export var set_collision:bool = false
## Это [param CollisionObject2D.collision_layer]
@export_flags_2d_physics var layer:int = 0
## Это [param CollisionObject2D.collision_mask]
@export_flags_2d_physics var mask:int = 0
## Это [param CollisionObject2D.collision_priority]
@export var input_pickable:bool = false
@export_group("Linear")
## Нужно ли устанавливать значения для группы Linear 
@export var set_linear:bool = false
@export var linear_velocity:Vector2 = Vector2.ZERO

func _execute(...args:Array) -> void:
	execution_started.emit()
	if not target_node: 
		executed.emit()
		executed_failed.emit()
		return
	if set_collision:
		target_node.collision_layer = layer
		target_node.collision_mask = mask
		target_node.input_pickable = input_pickable
	if set_linear:
		
		target_node.linear_velocity = linear_velocity
	executed.emit()
	executed_good.emit()

func _ready():
	super._ready()

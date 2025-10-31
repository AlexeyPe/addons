@tool
extends APChain
class_name APChainSetDropSuccess

@export var drop_zone:APDropZone
@export var skip_success:bool = false
@export var success:bool = true
@export var skip_can_drop:bool = false
@export var can_drop:bool = false


func _execute(...args:Array) -> void:
	if drop_zone:
		drop_zone.set_drop_success(
			skip_success, success, skip_can_drop, can_drop
		)
	executed.emit()

extends Node
class_name APMouseTarget2D

@export var node:Node2D
@export var invert:bool : set = set_invert

func set_invert(new:bool):
	invert = new
	if invert:
		_invert = -1
	else:
		_invert = 1
	
var _invert:int = 1

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	if get_viewport().get_mouse_position().x > node.global_position.x:
		node.scale.x = abs(node.scale.x) * _invert
	else:
		node.scale.x = -abs(node.scale.x) * _invert
	_ready()

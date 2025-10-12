extends APController
class_name APContDirTarget2D

@export var body_2d:CharacterBody2D
@export var node_scale:Node2D
@export var invert:bool : set = set_invert

func set_invert(new:bool):
	invert = new
	if invert:
		_invert = -1
	else:
		_invert = 1
var _invert:int = 1

func _ready() -> void:
	if body_2d.velocity.x > 0:
		node_scale.scale.x = abs(node_scale.scale.x) * _invert
	else:
		node_scale.scale.x = -abs(node_scale.scale.x) * _invert

func _physics_process(delta: float) -> void:
	if body_2d.velocity.x > 0:
		node_scale.scale.x = abs(node_scale.scale.x) * _invert
	else:
		node_scale.scale.x = -abs(node_scale.scale.x) * _invert

@tool
extends APChain
class_name APChainShakeUI

@export var target:Control


func _execute(...args:Array) -> void:
	if target:
		target.material
		target.material.set_shader_parameter("y_rot", 1)

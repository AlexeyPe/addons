@tool
extends APChain
class_name APChainShakeUI

@export var target:Control
@export var duration_to:float = 0
@export var duration_out:float = 1.0
var tween:Tween

func _tween_method(x):
	target.material.set_shader_parameter("hit_effect", x)

func _execute(...args:Array) -> void:
	if target:
		target.material
		if tween:
			tween.kill()
		if duration_to > 0.0:
			tween = get_tree().create_tween()
			tween.tween_method(_tween_method, 0.0, 1.0, duration_to)
			await tween.finished
		else:
			_tween_method(1.0)
		if duration_out > 0.0:
			if tween:
				tween.kill()
			tween = get_tree().create_tween()
			tween.tween_method(
				_tween_method,
				target.material.get_shader_parameter("hit_effect"),
				0.0, duration_out
			)

@tool
extends APChain
class_name APChainShake2D

enum SHAKE_TYPE {RANDOM, NOISE}

func _execute(...args:Array):
	
	pass

@export var target_node_shake:Node2D
## Как быстро прекращается дрожь
@export_range(0.0, 1.0, 0.05) var decay:float = 0.5
## Максимальное горизонтальное/вертикальное дрожание в пикселях
@export var max_offset = Vector2(100, 75)
## Максимальное вращение в радианах (использовать с осторожностью)
@export_range(0, 2.0, 0.1) var max_roll:float = 0.1
## Является соотношением между trauma и фактическим движением
@export_range(1.0, 3.0, 0.5) var trauma_power = 2.0
@export_range(0.0, 1.0, 0.05) var add_trauma:float = 0.5
@export var shake_type:SHAKE_TYPE = SHAKE_TYPE.RANDOM
@export var noise:FastNoiseLite
@export_tool_button("Add trauma!") var button_add_trauma = func():
	trauma = min(trauma + add_trauma, 1.0)


var shake_noise:Noise
var trauma = 0.0
var noise_y:float = 0.0

func _get_execute() -> Callable:
	return func(arg:Variant = null):
		trauma = min(trauma + add_trauma, 1.0)

func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()

func shake():
	var amount = pow(trauma, trauma_power)
	match shake_type:
		SHAKE_TYPE.RANDOM:
			target_node_shake.rotation = max_roll * amount * randf_range(-1, 1)
			target_node_shake.offset.x = max_offset.x * amount * randf_range(-1, 1) 
			target_node_shake.offset.y = max_offset.y * amount * randf_range(-1, 1)
		SHAKE_TYPE.NOISE:
			noise_y += 1.0
			target_node_shake.rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
			target_node_shake.offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
			target_node_shake.offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)

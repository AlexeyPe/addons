@tool
extends APChain
class_name APChainParticles

@export var cpu_particle2D:CPUParticles2D

@export var new_emitting:bool = true
@export var set_amount:bool = false
@export var new_amount:VaRNumber

func _execute(...args:Array) -> void:
	if cpu_particle2D:
		if set_amount and new_amount != null:
			cpu_particle2D.amount = new_amount.get_value()
		cpu_particle2D.emitting = new_emitting

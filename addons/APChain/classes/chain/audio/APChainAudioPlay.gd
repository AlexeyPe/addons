@tool
extends APChain
class_name APChainAudioPlay

@export var player:AudioStreamPlayer
@export var from_position:float = 0.0

func _execute(...args:Array) -> void:
	execution_started.emit()
	if player:
		player.play(from_position)
	executed.emit()
	executed_good.emit()

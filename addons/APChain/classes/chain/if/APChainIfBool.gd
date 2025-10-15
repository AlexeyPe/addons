@tool
extends APChain
class_name APChainIfBool

signal if_true
signal if_false

## Если _bool == value, то if_true, иначе if_false
@export var bools:Array[VaRBool]
## Если _bool == value, то if_true, иначе if_false
@export var value:bool

func _execute(...args:Array) -> void:
	execution_started.emit()
	for _bool in bools:
		if !_bool: continue
		if _bool.value != value:
			if_false.emit()
			executed_good.emit()
			executed.emit()
			return
	if_true.emit()
	executed_good.emit()
	executed.emit()

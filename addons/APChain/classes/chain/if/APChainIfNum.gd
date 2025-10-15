@tool
extends APChain
class_name APChainIfNum

## Вызывается условие выполняется
signal if_true
## Вызывается условие не выполняется
signal if_false

@export var num_a:VaRNumber
@export var num_b:VaRNumber
@export_enum(
	"a == b",
	"a != b",
	"a > b",
	"a < b",
	"a >= b",
	"a <= b",
) var condition:int

func _execute(...args:Array) -> void:
	execution_started.emit()
	if !num_a:
		executed_failed.emit()
		printerr("APChainIfNum, num_a is null %s"%[])
	if !num_b:
		executed_failed.emit()
		printerr("APChainIfNum, num_b is null %s"%[])
	var check:bool = false
	match condition:
		0: # a == b
			check = num_a.get_value() == num_b.get_value()
		1: # a != b
			check = num_a.get_value() != num_b.get_value()
		2: # a > b
			check = num_a.get_value() > num_b.get_value()
		3: # a < b
			check = num_a.get_value() < num_b.get_value()
		4: # a >= b
			check = num_a.get_value() >= num_b.get_value()
		5: # a <= b
			check = num_a.get_value() <= num_b.get_value()
	if check:
		if_true.emit()
	else:
		if_false.emit()
	executed.emit()
	executed_good.emit()

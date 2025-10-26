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
## Оставить пустым что бы пропустить это выполнение.[br]
## Заменит num_a на мету из node_emitter.[br]
## Мета добавляется/перезаписывается в метаданные цепочки.
@export var num_a_is_meta_emitter:String = ""

func _execute(...args:Array) -> void:
	execution_started.emit()
	if !num_a_is_meta_emitter.is_empty():
		print("APChainIfNum meta execute")
		if node_emitter.has_meta(num_a_is_meta_emitter):
			var meta = node_emitter.get_meta(num_a_is_meta_emitter)
			if meta and meta is VaRNumber:
				print("APChainIfNum meta execute set num_a ", meta)
				num_a = meta
				set_meta(num_a_is_meta_emitter, meta)
			else: return
		else: return
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

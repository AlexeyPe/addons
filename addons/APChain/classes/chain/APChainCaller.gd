@tool
extends APChain
class_name APChainCaller

## Делает 5-7(любое) вызовов за 1 секунду. [br]
## Иногда может быть много вызовов(20+).[br]
## Если вызовов много то увеличить время с 1 до 2 секунд и т.д. [br]

## Будет вызываться Х раз за Y времени
signal iter_call

@export var time_boost:float = 1.0
@export var num_x:VaRNumber
## Значение по горизонтали это X (num_x)
## Значение по вертикали это Y - количество секунд
@export var calls_per_second:Curve
@export var test_num_x:int = 10
## Задержка перед началом выдачи вызовов iter_call
@export var start_delay:float = 0.0
@export_tool_button("test") var test = func():
	prints(
		"test_num_x:",test_num_x,
		"total_sec:", calls_per_second.sample(test_num_x),
		"call_per_sec:", calls_per_second.sample(test_num_x)/test_num_x
	)
	pass

func _execute(...args:Array) -> void:
	if start_delay:
		await get_tree().create_timer(start_delay).timeout
	var value = num_x.get_value()
	var call_per_sec:float = (calls_per_second.sample(value)/value)*time_boost
	for i in value:
		if i == 0:
			iter_call.emit()
		else:
			await get_tree().create_timer(call_per_sec).timeout
			iter_call.emit()

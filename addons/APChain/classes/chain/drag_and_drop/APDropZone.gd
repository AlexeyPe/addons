extends Control
class_name APDropZone

## Не учитывая что пытаются сюда бросить, можно или нет?
@export var can_drop:VaRBool
## Если can_drop = true, тогда провести эти проверки.[br]
## Что бы разрешить drop все проверки должны пройти.[br]
## Для проверки используются metadata ноды которая переносится
@export var can_drop_check:Array[MetaCondition]
## Это как can_drop_check, но только в момент броска
@export var drop_data_check:Array[MetaCondition]
## Пример использования:[br]
## False - карточка после drop вернётся в колоду,
## но её количество потратится.[br]
## False - можно использовать для отладки.
@export var after_drop_set_success:bool = true
## MetaCondition использует metadata которые берутся из drop node
@export var drop_meta_conditions:Array[MetaCondition]
@export_group("When can drop")
## Сделать visible true когда _can_drop_data true
@export var visible_true:Array[Node]
## Сделать visible false когда курсор мыши ушёл
@export var visible_false:Array[Node]

func _ready() -> void:
	mouse_exited.connect(on_mouse_exited)

func on_mouse_exited():
	for node in visible_false:
		if "visible" in node:
			node.visible = false

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	#print("APDropZone _can_drop_data")
	for node in visible_false:
		if "visible" in node:
			node.visible = true
	return can_drop.get_value()

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is APDragDataControl:
		var check:bool = true
		if !drop_data_check.is_empty():
			for drop_check in drop_data_check:
				if drop_check.check(data) == false:
					check = false
					break
		if check:
			data.set_meta("_drop_success", true)
			for meta_cond in drop_meta_conditions:
				meta_cond.check(data)
			can_drop.value = false
		return

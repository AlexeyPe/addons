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
## Попытается перезаписать value из APDragDataRes.[br]
## APDragDataRes resource_name => [VarRes]
@export var set_vares_value:Dictionary[String, VarRes]
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
	if data is APDragDataRes:
		var check:bool = true
		if !drop_data_check.is_empty():
			for drop_check in drop_data_check:
				if drop_check.check(data.dragged_node) == false:
					check = false
					break
		if check:
			data.success = after_drop_set_success
			for vares in data.vares:
				if vares.resource_name.is_empty(): continue
				var find = set_vares_value.get(vares.resource_name)
				if find:
					find.paste(vares)
			can_drop.value = false
		else:
			data.success = false

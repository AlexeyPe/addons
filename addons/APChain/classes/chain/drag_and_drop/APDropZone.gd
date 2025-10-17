extends Control
class_name APDropZone

@export var can_drop:VaRBool
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
		data.success = after_drop_set_success
		for vares in data.vares:
			if vares.resource_name.is_empty(): continue
			var find = set_vares_value.get(vares.resource_name)
			if find:
				print(vares)
				find.paste(vares)
		can_drop.value = false

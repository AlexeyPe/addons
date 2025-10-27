extends Control
class_name APDropZone

## Не учитывая что пытаются сюда бросить, можно или нет?
@export var can_drop:VaRBool
## Пример использования:[br]
## False - карточка после drop вернётся в колоду,
## но её количество потратится.[br]
## False - можно использовать для отладки.
@export var after_drop_set_success:bool = true
@export var metadata_container:APActivatorInteraction
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
	if can_drop.get_value():
		for node in visible_false:
			if "visible" in node:
				node.visible = true
	return can_drop.get_value()

func _drop_data(at_position: Vector2, data: Variant) -> void:
	#print("APDropZone _drop_data(data:%s)"%[data])
	if data is Node:
		if data.has_meta("_drop_success") == false: return
		if metadata_container:
			for meta in metadata_container.get_meta_list():
				metadata_container.remove_meta(meta)
			for meta in data.get_meta_list():
				metadata_container.set_meta(meta, data.get_meta(meta))
			metadata_container.activated.emit()
		#print("APDropZone _drop_data() _drop_success set true")
		data.set_meta("_drop_success", true)
		can_drop.value = false

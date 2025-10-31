extends Control
class_name APDropZone

## Не учитывая что пытаются сюда бросить, можно или нет?
@export var can_drop:VaRBool
@export var metadata_container:APActivatorInteraction
@export_group("When drop", "when_drop_")
@export var when_drop_set_vector:VaRVector2
## Пример использования:[br]
## False - карточка после drop вернётся в колоду,
## но её количество потратится.[br]
## False - можно использовать для отладки.
@export var when_drop_set_success:bool = true
@export var when_drop_set_can_drop:bool = true
# Нода-владелец для координат
#@export var when_drop_set_vector_owner2D:Node2D
@export_group("When can drop")
## Сделать visible true когда _can_drop_data true
@export var visible_true:Array[Node]
## Сделать visible false когда курсор мыши ушёл
@export var visible_false:Array[Node]

# Записывает только когда when_drop_set_success = false
var last_drop:Node

func set_drop_success(
	skip_success, success, skip_can_drop, _can_drop
):
	if last_drop == null:
		printerr("APDropZone last_drop == null")
		return
	if !skip_success:
		last_drop.set_meta("_drop_success", success)
	if !skip_can_drop:
		can_drop.value = _can_drop

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
		if when_drop_set_vector:
			when_drop_set_vector.set_value(get_global_mouse_position())
		if data.has_meta("_drop_success") == false: return
		if when_drop_set_success:
			data.set_meta("_drop_success", true)
		else:
			last_drop = data
		if when_drop_set_can_drop:
			can_drop.value = false
		else:
			last_drop = data
		if metadata_container:
			for meta in metadata_container.get_meta_list():
				metadata_container.remove_meta(meta)
			for meta in data.get_meta_list():
				metadata_container.set_meta(meta, data.get_meta(meta))
			metadata_container.activated.emit()

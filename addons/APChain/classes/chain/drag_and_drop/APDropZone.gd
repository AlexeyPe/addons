extends Control
class_name APDropZone

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
	return true

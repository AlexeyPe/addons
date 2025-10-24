@tool
extends APActivator
class_name APActivatorInteraction

@export_group("Body")
@export var rigid_body_2D:RigidBody2D
@export var rigid_body_3D:RigidBody3D
@export_enum(
	"body_entered",
	"body_exited",
) var body_signal:String = "body_entered"

func set_meta_list(new:Dictionary[StringName, Variant]):
	if not enable: return
	for meta in get_meta_list():
		remove_meta(meta)
	for new_meta in new.keys():
		set_meta(new_meta, new[new_meta])
	activated.emit()

func _change_enable():
	if enable:
		if rigid_body_2D:
			if not rigid_body_2D.is_connected(body_signal, target_emit):
				rigid_body_2D.connect(body_signal, target_emit)
		elif rigid_body_3D:
			if not rigid_body_3D.is_connected(body_signal, target_emit):
				rigid_body_3D.connect(body_signal, target_emit)
	else:
		if rigid_body_2D:
			if rigid_body_2D.is_connected(body_signal, target_emit):
				rigid_body_2D.disconnect(body_signal, target_emit)
		elif rigid_body_3D:
			if rigid_body_3D.is_connected(body_signal, target_emit):
				rigid_body_3D.disconnect(body_signal, target_emit)

func target_emit(...args:Array):
	#var body: Node = args[0]
	var meta_list:Dictionary[StringName, Variant]
	for meta in args[0].get_meta_list():
		meta_list[meta] = args[0].get_meta(meta)
	set_meta_list(meta_list)

func _ready() -> void:
	_change_enable()

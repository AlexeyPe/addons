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
@export_group("Area")
@export_subgroup("overlapping_bodies", "overlapping_bodies_")
@export var overlapping_bodies_area2D:Area2D
@export var overlapping_bodies_vares:VarRes

func _change_enable():
	if enable:
		if overlapping_bodies_area2D and overlapping_bodies_area2D:
			if not overlapping_bodies_vares.is_connected("changed", target_emit_area):
				overlapping_bodies_vares.connect("changed", target_emit_area)
		if rigid_body_2D:
			if not rigid_body_2D.is_connected(body_signal, target_emit_body):
				rigid_body_2D.connect(body_signal, target_emit_body)
		elif rigid_body_3D:
			if not rigid_body_3D.is_connected(body_signal, target_emit_body):
				rigid_body_3D.connect(body_signal, target_emit_body)
	else:
		if rigid_body_2D:
			if rigid_body_2D.is_connected(body_signal, target_emit_body):
				rigid_body_2D.disconnect(body_signal, target_emit_body)
		elif rigid_body_3D:
			if rigid_body_3D.is_connected(body_signal, target_emit_body):
				rigid_body_3D.disconnect(body_signal, target_emit_body)

func target_emit_body(...args:Array):
	if not enable: return
	for meta in get_meta_list():
		remove_meta(meta)
	for meta in args[0].get_meta_list():
		set_meta(meta, args[0].get_meta(meta))
	activated.emit()

func target_emit_area(...args:Array):
	if not enable: return
	for body in overlapping_bodies_area2D.get_overlapping_bodies():
		#print("APActivatorInteraction overlapping_bodies:", body)
		for meta in get_meta_list():
			remove_meta(meta)
		for meta in body.get_meta_list():
			set_meta(meta, body.get_meta(meta))
		activated.emit()

func _ready() -> void:
	_change_enable()

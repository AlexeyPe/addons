@tool
extends Node
class_name APCameraZoomIsNum

@export var camera:Camera2D
@export var vares_target:VaRNumber :
	set(new):
		if vares_target and vares_target.changed.is_connected(on_changed_vares_target):
			vares_target.changed.disconnect(on_changed_vares_target)
		vares_target = new
		if vares_target:
			vares_target.changed.connect(on_changed_vares_target)
			on_changed_vares_target()
		on_changed_vares_target()

func on_changed_vares_target():
	if is_node_ready():
		assert(vares_target != null, "vares_target is null, %s"%[self.get_path()])
		assert(camera != null, "camera is null, %s"%[self.get_path()])
		var value = float(vares_target.get_value())
		camera.zoom = Vector2(value, value)

func _ready() -> void:
	assert(camera != null, "camera is null, %s"%[self.get_path()])
	assert(vares_target != null, "vares_target is null, %s"%[self.get_path()])
	if vares_target and\
		not vares_target.changed.is_connected(on_changed_vares_target):
		vares_target.changed.connect(on_changed_vares_target)
		on_changed_vares_target()

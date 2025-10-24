@tool
extends StaticBody2D
class_name StaticBody2DVaRes

@export_group("VaRes Number")
@export var num:VaRNumber :
	set(new):
		if num and num.changed.is_connected(on_changed_vars):
			num.changed.disconnect(on_changed_vars)
		num = new
		if new: num.changed.connect(on_changed_vars)
		update_body()
@export_flags_2d_physics var num_is_collision_layer:Array[int]
@export_flags_2d_physics var num_is_collision_mask:Array[int]
@export var num_is_modulate:Array[Color] : 
	set(new):
		num_is_modulate = new
		update_body()

var debug:CanvasLayer

func on_changed_vars():
	update_body()

func update_body():
	if !num_is_modulate.is_empty() and num_is_modulate.size()-1 >= num.get_value():
		modulate = num_is_modulate.get(num.get_value())
	if !num_is_collision_layer.is_empty() and num_is_collision_layer.size()-1 >= num.get_value():
		collision_layer = num_is_collision_layer.get(num.get_value())
	if !num_is_collision_mask.is_empty() and num_is_collision_mask.size()-1 >= num.get_value():
		collision_mask = num_is_collision_mask.get(num.get_value())

func _ready() -> void:
	update_body()


func _mouse_enter() -> void:
	var layer = CanvasLayer.new()
	var label = Label.new()
	layer.add_child(label)
	debug = layer
	label.text = "%s, collision_layer:%s, collision_mask:%s"%[
		name, collision_layer, collision_mask
	]
	get_tree().root.add_child(layer)

func _mouse_exit() -> void:
	if debug:
		debug.queue_free()

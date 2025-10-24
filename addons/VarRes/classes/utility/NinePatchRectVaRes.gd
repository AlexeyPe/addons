@tool
extends NinePatchRect
class_name NinePatchRectVaRes

@export_group("VaRes Number")
@export var num:VaRNumber :
	set(new):
		if num and num.changed.is_connected(on_changed_vars):
			num.changed.disconnect(on_changed_vars)
		num = new
		if new: num.changed.connect(on_changed_vars)
		update_rect()
@export var num_is_modulate:Array[Color] : 
	set(new):
		num_is_modulate = new
		update_rect()

func on_changed_vars():
	update_rect()

func update_rect():
	if !num_is_modulate.is_empty() and num_is_modulate.size()-1 >= num.get_value():
		modulate = num_is_modulate.get(num.get_value())

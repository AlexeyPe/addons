@tool
extends Label
class_name VaResLabel

@export var var_res:VaRNumber : set = set_var_res
@export var num_is:Array[String]
@export var num_is_font_color:Array[Color]

func update_label():
	if !num_is.is_empty() and num_is.size()-1 >= var_res.get_value():
		text = num_is[var_res.get_value()]
		if !num_is_font_color.is_empty() and\
			num_is_font_color.size()-1 >= var_res.get_value():
			label_settings.font_color = num_is_font_color[var_res.get_value()]
	else:
		text = str(var_res.get_value())

func on_var_res_changed():
	update_label()

func set_var_res(new:VaRNumber):
	if var_res and var_res.changed.is_connected(on_var_res_changed):
		var_res.changed.disconnect(on_var_res_changed)
	var_res = new
	if new: var_res.changed.connect(on_var_res_changed)
	update_label()

func _ready() -> void:
	update_label()

@tool
extends Label
class_name VaResLabel

@export var var_res:VaRNumber : set = set_var_res

func update_label():
	text = str(var_res.get_value())

func on_var_res_changed():
	update_label()

func set_var_res(new:VaRNumber):
	if var_res and var_res.changed.is_connected(on_var_res_changed):
		var_res.changed.disconnect(on_var_res_changed)
	var_res = new
	if new: var_res.changed.connect(on_var_res_changed)
	update_label()

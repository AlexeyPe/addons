@tool
extends SpinBox
class_name VaResSpinBox

@export var var_res:VaRNumber : set = set_var_res
@export var prefix_is_var_res:bool = false : set = set_prefix_is_var_res
@export var suffix_is_var_res:bool = false : set = set_suffix_is_var_res

func set_prefix_is_var_res(new:bool):
	prefix_is_var_res = new
	update_spinbox()
	
func set_suffix_is_var_res(new:bool):
	suffix_is_var_res = new
	update_spinbox()

func _ready() -> void:
	if not value_changed.is_connected(on_value_changed):
		value_changed.connect(on_value_changed)

func on_value_changed(new_value: float) -> void:
	#print("_value_changed")
	if !var_res: return
	if typeof(var_res.get_value()) == TYPE_FLOAT:
		if var_res.get_value() != new_value:
			var_res.set_value(new_value)
	else:
		if var_res.get_value() != int(new_value):
			var_res.set_value(int(new_value))

func update_spinbox():
	#print("update_spinbox")
	if typeof(var_res.get_value()) == TYPE_FLOAT:
		step = 0.001
		max_value = clamp(var_res.get_max_value(), -9999e8, 9999e8)
		min_value = clamp(var_res.get_min_value(), -9999e8, 9999e8)
	else:
		step = 1
	max_value = clamp(var_res.get_max_value(), -9999e11, 9999e11)
	min_value = clamp(var_res.get_min_value(), -9999e11, 9999e11)
	prefix = ""
	suffix = ""
	if prefix_is_var_res:
		prefix = var_res.resource_path.get_file().split(".")[0]
	if suffix_is_var_res:
		suffix = var_res.resource_path.get_file().split(".")[0]
	if value != var_res.get_value():
		value = var_res.get_value()

func on_var_res_changed():
	update_spinbox()

func set_var_res(new:VaRNumber):
	if var_res and var_res.changed.is_connected(on_var_res_changed):
		var_res.changed.disconnect(on_var_res_changed)
	var_res = new
	if new == null:
		min_value = 0.0 
		max_value = 100.0
		value = 0
		prefix = ""
	else:
		var_res.changed.connect(on_var_res_changed)
		update_spinbox()

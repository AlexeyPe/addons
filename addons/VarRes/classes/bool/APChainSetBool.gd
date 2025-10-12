@tool
extends APChain
class_name APChainSetBool

@export var var_bool:VaRBool
@export var new_value:bool = true
## Пропуск если var_bool равен new_value 
@export var skip_if_equal:bool = true
@export_tool_button("Rename node") var _rename = _rename_self

func _rename_self():
	if var_bool:
		if var_bool.resource_name.is_empty():
			printerr("APChainSetBool, var_bool resource_name is empty, %s"%[get_path()])
		else:
			name = "SET_%s=%s"%[var_bool.resource_name, new_value]
	else:
		printerr("APChainSetBool, var_bool is empty, %s"%[get_path()])

func _execute(...args:Array) -> void:
	execution_started.emit()
	if var_bool:
		if skip_if_equal:
			if var_bool.value != new_value:
				var_bool.value = new_value
		else:
			var_bool.value = new_value
		executed.emit()
		executed_good.emit()

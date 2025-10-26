@tool
extends APChain
class_name APChainSetBool

@export var var_bool:VaRBool
## Оставить пустым что бы пропустить это выполнение.[br]
## Заменит num_a на мету из meta_owner.[br]
## Мета добавляется/перезаписывается в метаданные цепочки.
@export var bool_is_meta:String = ""
## Оставить пустым что бы пропустить это выполнение.[br]
@export var meta_owner:Node
@export var new_value:bool = true
## Пропуск если var_bool равен new_value 
@export var skip_if_equal:bool = true
## Подождать перед установкой нового bool
@export var wait:float = 0.0
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
	print("APChainSetBool execute")
	#print("set (bool %s) to %s"%[var_bool, new_value])
	if !bool_is_meta.is_empty() and meta_owner:
		print("APChainSetBool execute check meta ", bool_is_meta)
		if meta_owner.has_meta(bool_is_meta):
			var data = meta_owner.get_meta(bool_is_meta)
			if data and data is VaRBool:
				if wait > 0.0:
					await get_tree().create_timer(wait).timeout
				if skip_if_equal:
					if data.value != new_value:
						data.value = new_value
				else:
					data.value = new_value
				executed.emit()
				executed_good.emit()
	elif var_bool:
		if wait > 0.0:
			await get_tree().create_timer(wait).timeout
		if skip_if_equal:
			if var_bool.value != new_value:
				var_bool.value = new_value
		else:
			var_bool.value = new_value
		executed.emit()
		executed_good.emit()

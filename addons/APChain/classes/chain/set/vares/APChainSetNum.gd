@tool
extends APChain
class_name APChainSetNum

@export var num_a:VaRNumber
@export var num_b:VaRNumber
@export_enum(
	"a = b",
	"a += b",
	"a -= b",
) var operation:int

@export_tool_button("Rename node") var _rename = _rename_self

func _rename_self():
	if num_a:
		if num_a.resource_name.is_empty():
			printerr("APChainSetNum, num_a resource_name is empty, %s"%[get_path()])
		else:
			name = "SET_%s"%[num_a.resource_name]
	else:
		printerr("APChainSetNum, num_a is empty, %s"%[get_path()])


func _execute(...args:Array) -> void:
	execution_started.emit()
	if !num_a:
		push_error("APChainSetNum, num_a is null, %s"%[get_path()])
		executed_failed.emit()
		return
	if !num_b:
		push_error("APChainSetNum, num_b is null, %s"%[get_path()])
		executed_failed.emit()
		return
	match operation:
		0: # a = b
			num_a.set_value(num_b.get_value())
		1: # a += b
			num_a.set_value(num_a.get_value() + num_b.get_value())
		2: # a -= b
			num_a.set_value(num_a.get_value() - num_b.get_value())
		_:
			push_error("APChainSetNum, operation(%s) not found, %s"%[operation, get_path()])
			executed_failed.emit()
	executed.emit()
	executed_good.emit()

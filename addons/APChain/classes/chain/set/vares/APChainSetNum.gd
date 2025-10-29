@tool
extends APChain
class_name APChainSetNum

@export var disable_when_editor:bool = false
@export var num_a:VaRNumber
@export_group("num_a settings", "num_a_")
@export var num_a_is_arr:Array[VaRNumber]
@export var num_a_arr_index:VaRNumber
@export var num_a_arr_index_meta:String
@export var num_a_arr_index_meta_owner:Node
@export_group("")
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
	if disable_when_editor and Engine.is_editor_hint():return
	execution_started.emit()
	if num_a_is_arr.is_empty() == false:
		if num_a_arr_index != null and num_a_is_arr.size() >= num_a_arr_index.get_value():
			num_a = num_a_is_arr[num_a_arr_index.get_value()]
		elif !num_a_arr_index_meta.is_empty() and num_a_arr_index_meta_owner:
			var meta = num_a_arr_index_meta_owner.get_meta(num_a_arr_index_meta)
			if meta is VaRNumber:
				num_a = num_a_is_arr[meta.get_value()]
		if num_a == null: 
			executed.emit()
			#print("APChainSetNum return")
			return
	if num_a == null:
		push_error("APChainSetNum, num_a is null, %s"%[get_path()])
		executed_failed.emit()
		return
	if num_b == null:
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

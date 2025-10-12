@tool
extends APChainSetBool
class_name APChainSetBoolIfNum

@export var num_a:VaRNumber
@export var num_b:VaRNumber
@export_enum(
	"a == b",
	"a != b",
	"a > b",
	"a < b",
	"a >= b",
	"a <= b",
) var condition:int

func _rename_self():
	if var_bool:
		if var_bool.resource_name.is_empty():
			printerr("APChainSetBoolIfNum, var_bool resource_name is empty, %s"%[get_path()])
		else:
			name = "SET_%s=%s_IfNum"%[var_bool.resource_name, new_value]
	else:
		printerr("APChainSetBoolIfNum, var_bool is empty, %s"%[get_path()])

func _execute(...args:Array) -> void:
	execution_started.emit()
	if var_bool:
		var check:bool = false
		match condition:
			0: # a == b
				check = num_a.get_value() == num_b.get_value()
			1: # a != b
				check = num_a.get_value() != num_b.get_value()
			2: # a > b
				check = num_a.get_value() > num_b.get_value()
			3: # a < b
				check = num_a.get_value() < num_b.get_value()
			4: # a >= b
				check = num_a.get_value() >= num_b.get_value()
			5: # a <= b
				check = num_a.get_value() <= num_b.get_value()
		if check:
			if skip_if_equal:
				if var_bool.value != new_value:
					var_bool.value = new_value
			else:
				var_bool.value = new_value
			executed.emit()
			executed_good.emit()
		else:
			executed.emit()
			executed_failed.emit()

func _ready() -> void:
	super._ready()
	assert(num_a != null, "APChainSetBoolIfNum num_a is null, %s"%[get_path()])
	assert(num_b != null, "APChainSetBoolIfNum num_b is null, %s"%[get_path()])

@tool @abstract
extends VaRNumber
class_name VaRCompute

enum OPERATION {ADD, SUBTRACTION, MULTIPLY}

@export var numbers:Array[VaRNumber] : set = set_numbers
@export var operation:OPERATION = OPERATION.ADD : set = set_operation

func set_operation(new: OPERATION):
	operation = new
	compute_numbers()
	emit_changed()

func on_change_number():
	compute_numbers()
	emit_changed()

func get_compute_number() -> Variant: return null

func compute_numbers():pass

func set_numbers(new:Array[VaRNumber]):
	for number in numbers:
		if number and number.changed.is_connected(on_change_number):
			number.changed.disconnect(on_change_number)
	numbers = new
	for number in numbers:
		if number:
			number.changed.connect(on_change_number)
	compute_numbers()
	on_change_number()

func get_value() -> Variant: return get_compute_number()

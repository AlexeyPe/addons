@tool
extends VaRCompute
class_name VaRComputeInt

@export var compute:int = 0

func get_compute_number() -> Variant: return compute

func compute_numbers():
	var nums:Array[VaRNumber] = []
	for number in numbers:
		if number:
			nums.append(number)
	match operation:
		OPERATION.ADD: 
			compute = 0
		OPERATION.SUBTRACTION:
			compute = nums[0].get_value()
		OPERATION.MULTIPLY: 
			compute = nums[0].get_value()
	for number_id in nums.size():
		match operation:
			OPERATION.ADD:
				compute += int(nums[number_id].get_value())
			OPERATION.SUBTRACTION:
				if number_id == 0: continue
				compute -= int(nums[number_id].get_value())
			OPERATION.MULTIPLY:
				if number_id == 0: continue
				compute *= int(nums[number_id].get_value())

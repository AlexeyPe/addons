@tool
extends VaRRandom
class_name VaRRandomScene

## Класс обёртка для типизации [method get_result] и [param elements]([method _get_elements])

## Элемент / вес элемента.[br]
## TODO VaRInt сделать сигнал на изменение только value.
@export var elements:Dictionary[PackedScene, VaRInt] :
	set(new):
		for elem_key in elements.keys():
			if !elem_key:continue
			if elements[elem_key].changed.is_connected(on_weight_changed):
				elements[elem_key].changed.disconnect(on_weight_changed)
		elements = new
		on_elements_changed()
		for elem_key in elements.keys():
			if !elem_key:continue
			elements[elem_key].changed.connect(on_weight_changed)

## Вовзращает случайный элемент([PackedScene]) из [param elements]
func get_result() -> PackedScene: return _get_result()

# Элемент / вес элемента:
func _get_elements() -> Dictionary[Variant, int]:
	var result:Dictionary[Variant, int]
	for elem_key in elements.keys():
		result[elem_key] = elements[elem_key].get_value()
	return result

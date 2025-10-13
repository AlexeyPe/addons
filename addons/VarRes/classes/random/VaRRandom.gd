@tool
@abstract
extends VarRes
class_name VaRRandom


## Вызывается при изменении весов элементов
signal weight_changed
## Вызывается при изменении элементов
signal elements_changed

## Вовзращает случайный элемент
@abstract func get_result() -> Variant

## Элемент / вес элемента. [br]
## больше вес - выше шансы, вес от 0 до бесконечности
@abstract func _get_elements() -> Dictionary[Variant, int]

# Сбрасывается при обновлении весов или элементов
# Это индекс для _elements_pos
@export_storage var _counter:int = 0

# Позиция элементов
# Сбрасывается при изменении весов или элементов
@export_storage var _elements_pos:Array[int]

@export var seed:int = 0

@export_tool_button("Print elements chance") var print_elem_chance = _print_elem_chance
@export_tool_button("Print 1 roll") var print_1_roll = _print_1_roll
@export_tool_button("Print 10 roll") var print_10_roll = _print_n_roll.bind(10)
@export_tool_button("Print 100 roll") var print_100_roll = _print_n_roll.bind(100)
@export_tool_button("Print 1000 roll") var print_1000_roll = _print_n_roll.bind(1000)
@export_range(1, 9999999, 1) var print_n:int = 10
@export_tool_button("Print N roll") var print_n_roll = _test_print_n_roll

func _test_print_n_roll():
	_print_n_roll(print_n)

func _print_n_roll(n:int):
	print("Print %s roll"%[n])
	var drops:Dictionary[Variant, int]
	for i in range(n):
		var result:Variant = _get_result()
		if drops.has(result):
			drops[result] += 1
		else:
			drops[result] = 1
	print("QuantityㅤDrop name")
	for drop_key in drops.keys():
		if drop_key is Resource and !drop_key.resource_name.is_empty():
			print("%8dㅤ%s"%[drops[drop_key], drop_key.resource_name])
		else:
			print("%8dㅤ%s"%[drops[drop_key], drop_key])
	_counter = 0
	_elements_pos.clear()

func _print_1_roll():
	var result:Variant = _get_result()
	if result is Resource:
		if !result.resource_name.is_empty():
			result = result.resource_name
	print("_get_result: ", result)
	_counter = 0
	_elements_pos.clear()
	pass

func _print_elem_chance():
	var elements: Dictionary[Variant, int] = _get_elements()
	var total_weight:int = 0
	for num in elements.values():
		total_weight += num
	print("total_weight:", total_weight)
	for elem_key in elements.keys():
		if !elem_key: continue
		var name:String = str(elem_key)
		if elem_key is Resource and !elem_key.resource_name.is_empty():
			name = elem_key.resource_name
		var chance:float= snapped(
			float(elements[elem_key])/float(total_weight),0.00001)*100.0
		prints(
			"weight: %5d"%elements[elem_key],
			"chance: %6.3f %%"%[chance],
			name
		)

## Вызывает [signal weight_changed]
func on_weight_changed():
	weight_changed.emit()
	_counter = 0
	_elements_pos.clear()

## Вызывает [signal elements_changed]
func on_elements_changed():
	elements_changed.emit()
	_counter = 0
	_elements_pos.clear()

func _get_result() -> Variant:
	seed(seed)
	var elements:Dictionary[Variant, int] = _get_elements()
	var elem_keys = elements.keys()
	if _elements_pos.is_empty():
		for elem_key_i in elem_keys.size():
			var arr:Array[int]
			arr.resize(elements[elem_keys[elem_key_i]])
			arr.fill(elem_key_i)
			_elements_pos.append_array(arr)
		_elements_pos.shuffle()
	var result:Variant = elem_keys[_elements_pos[_counter]]
	_counter += 1
	if _counter == _elements_pos.size():
		_counter = 0
	return result

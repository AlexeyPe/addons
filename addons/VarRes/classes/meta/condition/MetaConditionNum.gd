extends MetaCondition
class_name MetaConditionNum

@export var num:VaRNumber
@export_enum(
	"meta == num",
	"meta != num",
	"meta > num",
	"meta >= num",
	"meta < num",
	"meta <= num",
) var condition:int

func check(node:Node) -> bool:
	if meta_name.is_empty(): 
		printerr(
			"MetaConditionNum, meta_name is empty, %s"%[
				resource_path
			]
		)
		return false
	if !node.has_meta(meta_name):
		printerr(
			"MetaConditionNum, node(%s) meta not found, %s"%[
				node,
				resource_path
			]
		)
		return false
	var meta_value
	if node.get_meta(meta_name) is VaRNumber:
		meta_value = node.get_meta(meta_name).get_value()
	elif node.get_meta(meta_name) is int or\
		node.get_meta(meta_name) is float:
		meta_value = node.get_meta(meta_name)
	else:
		if_false.emit()
		return false
	var result:bool
	match condition:
		0: # meta == num
			if meta_value == num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
				return true
			else:
				if_false.emit()
				return false
		1: # meta != num
			if meta_value != num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
				return true
			else:
				if_false.emit()
				return false
		2: # meta > num
			if meta_value > num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
				return true
			else:
				if_false.emit()
				return false
		3: # meta >= num
			if meta_value >= num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
				return true
			else:
				if_false.emit()
				return false
		4: # meta < num
			if meta_value < num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
				return true
			else:
				if_false.emit()
				return false
		5: # meta <= num
			if meta_value <= num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
				return true
			else:
				if_false.emit()
				return false
		_: return false
func paste(data:Variant):
	if data is MetaConditionNum:
		num = data.num
		condition = data.condition
	else: printerr("MetaConditionNum func paste() need code")

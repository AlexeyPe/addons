extends MetaCondition
class_name MetaConditionNum

signal if_true
signal if_false

@export var num:VaRNumber
@export_enum(
	"meta == num",
	"meta != num",
	"meta > num",
	"meta >= num",
	"meta < num",
	"meta <= num",
) var condition:int

func check(node:Node):
	if meta_name.is_empty(): 
		printerr(
			"MetaConditionNum, meta_name is empty, %s"%[
				resource_path
			]
		)
		return
	if !node.has_meta(meta_name):
		printerr(
			"MetaConditionNum, node(%s) meta not found, %s"%[
				node,
				resource_path
			]
		)
		return
	var meta_value
	if node.get_meta(meta_name) is VaRNumber:
		meta_value = node.get_meta(meta_name).get_value()
	elif node.get_meta(meta_name) is int or\
		node.get_meta(meta_name) is float:
		meta_value = node.get_meta(meta_name)
	else:
		return
	var result:bool
	match condition:
		0: # meta == num
			if meta_value == num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
			else:
				if_false.emit()
		1: # meta != num
			if meta_value != num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
			else:
				if_false.emit()
		2: # meta > num
			if meta_value > num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
			else:
				if_false.emit()
		3: # meta >= num
			if meta_value >= num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
			else:
				if_false.emit()
		4: # meta < num
			if meta_value < num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
			else:
				if_false.emit()
		5: # meta <= num
			if meta_value <= num.get_value():
				if_true.emit()
				if meta_execute:
					meta_execute.execute()
			else:
				if_false.emit()
func paste(vares:VarRes):
	if vares is MetaConditionNum:
		num = vares.num
		condition = vares.condition
	else: printerr("MetaConditionNum func paste() need code")

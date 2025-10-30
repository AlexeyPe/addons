extends MetaCondition
class_name MetaConditionHasPaste

## Ресурс куда вставлять данные меты
@export var paste_vares:VarRes

func check(node:Node) -> bool:
	if !paste_vares:
		printerr("MetaConditionHasPaste, check(node:%s) paste_vares is null"%[
			node.get_path()	
		])
		if_false.emit()
		return false
	if node.has_meta(meta_name):
		var meta = node.get_meta(meta_name)
		paste_vares.paste(meta)
		if_true.emit()
		return true
	else:
		if_false.emit()
		return false

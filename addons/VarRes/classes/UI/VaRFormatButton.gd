@tool
extends Node
class_name VaRFormatButton

@export var res:Array[VaRNumber] : 
	set(new):
		for _res in res:
			if _res and _res.changed.is_connected(_update_text):
				_res.changed.disconnect(_update_text)
		res = new
		for _res in res:
			if _res and not _res.changed.is_connected(_update_text):
				_res.changed.connect(_update_text)

var init_text:String = ""

func _get_configuration_warnings() -> PackedStringArray:
	if get_parent() is Button:
		return []
	else:
		return ["Родительская нода должна быть Button"]

func _ready() -> void:
	#print("ready VaRNumberBBCode!")
	assert(get_parent() is Button, "VaRNumberBBCode parent in not Button, %s"%[get_path()])
	init_text = get_parent().text
	_update_text()

func _update_text():
	if Engine.is_editor_hint(): return
	#print("_update_text")
	assert(get_parent() is Button, "VaRNumberBBCode parent in not Button, %s"%[get_path()])
	var parent:Button = get_parent()
	var new_text = init_text
	for _res in res:
		if !_res: continue
		new_text = new_text.replace("{%s}"%[_res.resource_name], str(_res.get_value()))
	parent.text = new_text
	

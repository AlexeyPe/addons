@tool
extends Label
class_name LabelName

@export var target_node:Node : 
	set(new):
		if target_node and target_node.renamed.is_connected(update):
			target_node.renamed.disconnect(update)
		target_node = new
		if target_node and not target_node.renamed.is_connected(update):
			target_node.renamed.connect(update)
		update()

func update():
	if target_node:
		text = target_node.name
	else:
		text = ""

func _ready() -> void:
	update()

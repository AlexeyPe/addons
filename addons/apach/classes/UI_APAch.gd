@tool
extends Node

@export var achievement:APAch
@export_tool_button("Update parent name") var action_update_parent_name = update_parent_name

func update_parent_name():
	assert(get_parent() is Control, "%s parent is not Control. %s/%s"%[name, owner.name, owner.get_path_to(self)])
	assert(achievement != null, "achievement is null. %s/%s"%[owner.name, owner.get_path_to(self)])
	var new_name:String = "ach_%s"%[achievement.name]
	print("action: update parent name. old name:%s, new name:%s. %s/%s"%[get_parent().name, new_name, owner.name, owner.get_path_to(self)])
	get_parent().name = new_name

func on_achievement_changed():
	print("on_achievement_changed, APAch:", achievement)

func _ready() -> void:
	achievement.changed.connect(on_achievement_changed)
	on_achievement_changed()
	assert(get_parent() is Control, "%s parent is not Control. %s/%s"%[name, owner.name, owner.get_path_to(self)])

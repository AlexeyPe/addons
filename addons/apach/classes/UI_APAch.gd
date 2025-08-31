@tool
extends Node

@export var achievement:APAch : set = set_achievement
@export_tool_button("Rename this node") var action_rename = rename
@export_group("Scene settings")
@export var node_name:Label
@export var node_description:Label
@export var node_progressbar:ProgressBar
@export var node_icon:TextureRect

func rename():
	assert(achievement != null, "achievement is null. %s/%s"%[owner.name, owner.get_path_to(self)])
	var new_name:String = "ach_%s"%[achievement.name]
	print("action: update parent name. old name:%s, new name:%s. %s/%s"%[get_parent().name, new_name, owner.name, owner.get_path_to(self)])
	name = new_name

func set_achievement(new:APAch):
	print("UI_apach set_achievement, new:",new)
	if achievement and achievement.changed.is_connected(on_achievement_changed):
		achievement.changed.disconnect(on_achievement_changed)
	achievement = new
	achievement.changed.connect(on_achievement_changed)
	on_achievement_changed()

func on_achievement_changed():
	print("on_achievement_changed, APAch:", achievement)
	if node_name:
		node_name.text = achievement.name
	if node_description:
		node_description.text = achievement.description
	if node_progressbar:
		node_progressbar.max_value = achievement.target_value.get_value()
		node_progressbar.value = achievement.current_value.get_value()
	if node_icon:
		node_icon.texture = achievement.icon

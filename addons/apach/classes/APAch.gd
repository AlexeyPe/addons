@tool
extends Resource
class_name APAch

@export var icon:Texture
@export var name:String
@export var description:String

@export var target_value:VaRNumber : set = set_target_value
@export var current_value:VaRNumber

@export var rewards_value:Array[VaRQuantity]
@export var is_completed:bool : set = set_completed
var completed_timestamp:int = 0

func target_value_changed():
	print("target_value_changed, value:",target_value.get_value())
	pass

func set_target_value(new:VaRNumber):
	print("set_target_value")
	if target_value != null:
		if target_value.changed.is_connected(target_value_changed):
			target_value.changed.disconnect(target_value_changed)
	target_value = new
	pass

func current_value_changed():
	print("current_value_changed, value:",current_value.get_value())
	pass

func set_completed(new:bool):
	print("set_completed ", new)
	if not is_completed or Engine.is_editor_hint():
		is_completed = new
		completed_timestamp = Time.get_unix_time_from_datetime_dict(Time.get_datetime_dict_from_system(true))

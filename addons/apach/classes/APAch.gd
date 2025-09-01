@tool
extends Resource
class_name APAch

enum STATE { NOT_COMPLETED, COMPLETED, COLLECTED }

@export var icon:Texture : set = set_icon
@export var name:String : set = set_name
@export var description:String : set = set_description

@export var target_value:VaRNumber : set = set_target_value
@export var current_value:VaRNumber : set = set_current_value

@export var rewards_value:Array[VaRQuantity]
@export var state_skip_completed:bool = false : set = set_state_skip_completed
@export var state:STATE = STATE.NOT_COMPLETED : set = set_state
var completed_timestamp:int = 0

func set_icon(new:Texture): icon = new; emit_changed();
func set_name(new:String): name = new; emit_changed();
func set_description(new:String): description = new; emit_changed();

func _to_string() -> String:
	return "[%s, %s]"%[name, resource_path]

func set_state_skip_completed(new:bool):
	state_skip_completed = new
	if state == STATE.COMPLETED and state_skip_completed:
		state = STATE.COLLECTED

func target_value_changed():
	#print("target_value_changed, value:",target_value.get_value())
	emit_changed()
	pass

func set_target_value(new:VaRNumber):
	if target_value != null:
		if target_value.changed.is_connected(target_value_changed):
			target_value.changed.disconnect(target_value_changed)
	target_value = new
	if target_value != null:
		target_value.changed.connect(target_value_changed)
		target_value_changed()

func current_value_changed():
	#print("current_value_changed, value:",current_value.get_value())
	emit_changed()
	if current_value and target_value \
		and current_value.get_value() >= target_value.get_value():
		set_state(STATE.COMPLETED)

func set_current_value(new:VaRNumber):
	if current_value != null:
		if current_value.changed.is_connected(current_value_changed):
			current_value.changed.disconnect(current_value_changed)
	current_value = new
	if current_value != null:
		current_value.changed.connect(current_value_changed)
		current_value_changed()

func set_state(new:STATE):
	state = new
	if state == STATE.COMPLETED:
		completed_timestamp = Time.get_unix_time_from_datetime_dict(Time.get_datetime_dict_from_system(true))
		if state_skip_completed:
			state = STATE.COLLECTED
	emit_changed()

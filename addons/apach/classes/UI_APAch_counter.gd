@tool
extends Label
class_name LabelAchCounter

@export var achievements:Array[APAch] : set = set_achievements
@export var show_max:bool = false : set = set_show_max

func set_show_max(new:bool):
	show_max = new
	update_counter()

func set_achievements(new):
	print('set_achievements, new:',new)
	for ach in achievements:
		if ach and ach.changed.is_connected(update_counter):
			ach.changed.disconnect(update_counter)
	achievements = new
	for ach in achievements:
		if ach and not ach.changed.is_connected(update_counter):
			ach.changed.connect(update_counter)
	update_counter()

func update_counter():
	var counter:int = 0
	var counter_max:int = 0
	for ach in achievements:
		if ach:
			if ach.is_completed:
				counter += 1
			counter_max += 1
	if show_max:
		text = "%s/%s"%[counter, counter_max]
	else:
		text = var_to_str(counter)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_counter()

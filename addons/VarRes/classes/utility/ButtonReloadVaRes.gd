extends Button
class_name ButtonReloadVaRes

@export var reset_vares:Array[VaRNumber]

var vares_init_value:Dictionary[VaRNumber, Variant]

func _ready() -> void:
	vares_init_value.clear()
	for vares in reset_vares:
		if vares == null: continue
		vares_init_value[vares] = vares.get_value()

func _pressed() -> void:
	for vares in reset_vares:
		vares.set_value(vares_init_value[vares])
	get_tree().reload_current_scene()

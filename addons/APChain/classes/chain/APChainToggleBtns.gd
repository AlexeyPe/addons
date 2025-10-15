@tool
extends APChain
class_name APChainToggleBtns

## [param watch_signal] должен быть [signal BaseButton.pressed]

signal is_true_toggle
signal is_false_toggle

@export var counter_toggle_buttons:VaRInt
# Для хранения информации об этой цепочке между всеми цепочками сцены
@export var last_toggle:VaRPath
@export var toggle_bool:VaRBool

func _execute(...args:Array) -> void:
	assert(
		counter_toggle_buttons != null,
		"APChainToggleBtns, counter_toggle_buttons is null, %s"%[get_path()]
	)
	if node_emitter is BaseButton:
		if node_emitter.button_pressed:
			if counter_toggle_buttons.is_max():
				if !last_toggle.path.is_empty():
					if has_node(last_toggle.path):
						get_node(last_toggle.path).node_emitter.button_pressed = false
						get_node(last_toggle.path).toggle_bool.value = false
						get_node(last_toggle.path).is_false_toggle.emit()
					else:
						push_warning(
							"APChainToggleBtns, last_toggle has error path (not found node) %s"%[
								get_path()
							]
						)
					is_true_toggle.emit()
					last_toggle.path = get_path()
			else:
				counter_toggle_buttons.value += 1
				last_toggle.path = get_path()
				is_true_toggle.emit()
		else:
			counter_toggle_buttons.value -= 1
			last_toggle.clear()
			is_false_toggle.emit()
		toggle_bool.value = node_emitter.button_pressed

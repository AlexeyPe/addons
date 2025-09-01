extends Control

func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

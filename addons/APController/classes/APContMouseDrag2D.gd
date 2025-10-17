extends APController
class_name APContMouseDrag2D

@export var body:CharacterBody2D
@export var action_move:InputEventAction
#@export var cursor_when_drag:Input.CursorShape

#var cursor_before:Input.CursorShape
var can_move:bool = false

func _ready() -> void:
	if not Engine.is_editor_hint():
		assert(
			body != null,
			"body is null, %s"%[self.get_path()]
		)
		assert(
			action_move != null,
			"action_move is null, %s"%[self.get_path()]
		)
		pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(action_move.action):
		#cursor_before = Input.get_current_cursor_shape()
		#Input.set_default_cursor_shape(cursor_when_drag)
		can_move = true
	if event.is_action_released(action_move.action):
		#Input.set_default_cursor_shape(cursor_before)
		can_move = false
	if can_move and event is InputEventMouseMotion: 
		body.position -= event.relative

extends Node
class_name AP_WASD_2D

@export var character_body:CharacterBody2D
@export var move_speed:VaRFloat = VaRFloat.new(200)
@export_group("Input Actions")
@export var left:InputEventAction
@export var right:InputEventAction
@export var up:InputEventAction 
@export var down:InputEventAction

func _ready() -> void:
	if !left:
		left = InputEventAction.new()
		left.action = "ui_left"
	if !right:
		right = InputEventAction.new()
		right.action = "ui_right"
	if !up:
		up = InputEventAction.new()
		up.action = "ui_up"
	if !down:
		down = InputEventAction.new()
		down.action = "ui_down"

func _physics_process(delta):
	character_body.velocity = Input.get_vector(left.action, right.action, up.action, down.action) * move_speed.value
	character_body.move_and_collide(character_body.velocity * delta)

extends APController
class_name APContBounce2D

@export var body_2d:CharacterBody2D

var speed = 200

signal collision(collision:KinematicCollision2D)

func _ready() -> void:
	body_2d.velocity = Vector2(-200, -200).normalized() * speed

func _physics_process(delta: float) -> void:
	var _collision = body_2d.move_and_collide(body_2d.velocity * delta)
	if _collision:
		collision.emit(_collision)
		body_2d.velocity = body_2d.velocity.bounce(_collision.get_normal())

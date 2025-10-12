@icon("res://addons/APCards/imgs_required/mdi--cards.svg")
extends Node
class_name APCard2DPersp

## Нода для применения 2д проекции
@export var card_body:Node

#@export_range(-1, 1, 2) var invert:float = 1

@export_range(0.0, 1.0, 0.05) var angle_max_x:float = 0.5
@export_range(0.0, 1.0, 0.05) var angle_max_y:float = 0.5
#var shader:Shader = preload("res://addons/APCards/shaders/2D-perspective.gdshader")

var mat: ShaderMaterial

var tween:Tween

func _ready() -> void:
	assert(card_body != null, "card_body is null, %s"%[get_path()])	
	var mat:ShaderMaterial = card_body.material
	card_body.mouse_entered.connect(on_mouse_entered)
	card_body.mouse_exited.connect(on_mouse_exited)
	set_process(false)

func on_mouse_exited():
	set_process(false)
	if is_inside_tree() == false: return
	if tween: tween.kill()
	tween = get_tree().create_tween()
	tween.tween_method(
		func(v:Vector2):
			card_body.material.set_shader_parameter("x_rot", v.x);
			card_body.material.set_shader_parameter("y_rot", v.y);,
		Vector2(
			card_body.material.get_shader_parameter("x_rot"),
			card_body.material.get_shader_parameter("y_rot")
		),
		Vector2.ZERO, 0.2
	)

func on_mouse_entered():
	if get_tree() == null: return
	#if tween: tween.kill()
	set_process(true)

func get_rot() -> Vector2:
	# Получаем позицию мыши относительно элемента 'card_body'
	var mouse_pos: Vector2 = card_body.get_local_mouse_position()
	# Размер самого элемента 'card_body' (ширина и высота)
	var size = card_body.get_rect().size
	var clamped_mouse_pos = mouse_pos.clamp(Vector2.ZERO, size)
	# Определяем относительное положение мыши в пределах размера элемента (от 0 до 1)
	var rel = clamped_mouse_pos/size
	# Вычисляем углы поворота по осям X и Y с использованием линейной интерполяции
	return Vector2(
		rad_to_deg(lerp_angle(angle_max_x, -angle_max_x, rel.x)),  # угол поворота по оси X
		rad_to_deg(lerp_angle(-angle_max_y, angle_max_y, rel.y))   # угол поворота по оси Y
	)

func _process(delta: float) -> void:
	var rot = get_rot()
	card_body.material.set_shader_parameter("y_rot", rot.x)
	card_body.material.set_shader_parameter("x_rot", rot.y)

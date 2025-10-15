@tool
@icon("res://addons/APCards/imgs_required/mdi--cards.svg")
extends Container
class_name APDeckContainer

enum ADD_RULE {
	DEFAULT,
	CENTER_OFFSET,
}
enum ALIGNMENT {BEGIN, CENTER, END, END_REVERSE}

## TODO
@export var add_child_alignment:ADD_RULE
@export var alignment:ALIGNMENT : 
	set(new):
		alignment = new
		_sort_children()
## Расстояние между элементами в пикселях
@export var separation:float = 0.0 :
	set(new):
		separation = new
		_sort_children()
@export var fit:bool = true :
	set(new):
		fit = new
		_sort_children()
@export_group("Animation")
@export_range(0.0, 2.0, 0.05) var speed_move:float = 0.5
@export var transition_type:Tween.TransitionType = Tween.TransitionType.TRANS_SINE
@export var ease_type:Tween.EaseType = Tween.EaseType.EASE_IN_OUT
@export_group("Drag and Drop")
## Можно ли переместить сюда ноду, к примеру
@export var can_drop:bool = true

var tween:Tween
var child_old_pos:Dictionary[Control, Vector2]
var child_new_pos:Dictionary[Control, Vector2]
var child_to_size:Dictionary[Control, float]
var childs_size_x:float = 0.0

var fit_separation:float = 0.0

func _ready() -> void:
	sort_children.connect(_sort_children)
	#pre_sort_children.connect(_pre_sort_children)
	child_entered_tree.connect(on_child_entered_tree)
	child_exiting_tree.connect(on_child_exiting_tree)
	child_order_changed.connect(_child_order_changed)

var drop_node:Control = null

func on_child_exiting_tree(node:Node):
	child_old_pos.erase(node)
	child_new_pos.erase(node)

func on_child_entered_tree(node: Node):
	if node is Control:
		match add_child_alignment:
			ADD_RULE.CENTER_OFFSET:
				var center:float = get_rect().size.x*0.5
				node.position.x = childs_size_x+center-node.get_combined_minimum_size().x*0.5

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if drop_node == null:
		pass
	return can_drop

func _drop_data(at_position: Vector2, data: Variant) -> void:
	#print("_drop_data(at_position:%s, data:%s)"%[at_position, data])
	if data is APDragDataRes:
		data.success = true
		add_child(data.dragged_node)
		data.dragged_node.position = at_position
		_sort_children()

func _child_order_changed():
	#print("child_order_changed")
	pass

func _tween_move_childs(progress:float):
	for child in child_old_pos.keys():
		child.position.x = lerpf(child_old_pos[child].x, child_new_pos[child].x, progress)
		child.position.y = lerpf(child_old_pos[child].y, child_new_pos[child].y, progress)

# Используется для получения размера всех дочерних ui (childs_size_x)
func _update_child_to_size():
	child_to_size.clear()
	childs_size_x = 0.0
	var offset = _get_offset(separation)
	#prints("_update_child_to_size offset:",offset)
	for i in get_child_count():
		var child:Control = get_child(i)
		if child is Control:
			var c_size:Vector2 = child.get_combined_minimum_size()
			match alignment:
				ALIGNMENT.BEGIN:
					child_to_size[child] = c_size.x + separation
					childs_size_x += c_size.x + separation
				ALIGNMENT.END_REVERSE:
					if i == 0:
						child_to_size[child] = c_size.x
						childs_size_x += c_size.x
					else:
						child_to_size[child] = c_size.x + separation
						childs_size_x += c_size.x + separation
				ALIGNMENT.END:
					i = get_child_count()-i-1
					if i == 0:
						child_to_size[child] = c_size.x
						childs_size_x += c_size.x
					else:
						child_to_size[child] = c_size.x + separation
						childs_size_x += c_size.x + separation
				ALIGNMENT.CENTER:
					child_to_size[child] = c_size.x + separation
					childs_size_x += c_size.x + separation

func _get_offset(_separation:float) -> float:
	var offset:float = 0
	for _child in get_children():
		if _child is Control:
			#prints(
				#"_child:", _child,
				#"_child.get_rect().size.x:", _child.get_rect().size.x,
				#"_child.get_combined_minimum_size().x:", _child.get_combined_minimum_size().x
			#)
			offset += _child.get_combined_minimum_size().x
	#prints("_get_offset:", offset)
	return (get_rect().size.x - offset - _separation*get_child_count()) * 0.5 + _separation*0.5

func _pre_sort_children():
	#print("_pre_sort_children")
	pass

func _sort_children():
	#prints("_sort_children, get_child_count:", get_child_count())
	child_old_pos.clear()
	child_new_pos.clear()
	_update_child_to_size()
	var needless:float = childs_size_x - get_rect().size.x
	#prints("needless", needless)
	fit_separation = separation
	if fit and needless > 0:
		fit_separation = separation - (needless/get_child_count())
	var deck_center:float = get_rect().size.y * 0.5
	for i in get_child_count():
		var child:Control = get_child(i)
		#prints("i:",i,"child:",child)
		if child is Control:
			child_old_pos[child] = child.position
			child_new_pos[child] = child.position
			var c_size:Vector2 = child.get_combined_minimum_size()
			match alignment:
				ALIGNMENT.BEGIN:
					#prints("i:", i, "fit_separation/(get_child_count()-1):", fit_separation/(get_child_count()-1))
					# fit_separation/(get_child_count()-1) может быть как 0/0, поэтому выдаст NaN
					var value = i * (c_size.x + fit_separation + (fit_separation/(get_child_count()-1)))
					if is_nan(value):
						child_new_pos[child].x = 0.0
					else:
						child_new_pos[child].x = value
				ALIGNMENT.END_REVERSE:
					if i == 0:
						child_new_pos[child].x = get_rect().size.x - ((i+1) * (c_size.x))
					else:
						child_new_pos[child].x = get_rect().size.x - ((i+1) * (c_size.x + fit_separation)) + fit_separation
				ALIGNMENT.END:
					i = get_child_count()-i-1
					if i == 0:
						child_new_pos[child].x = get_rect().size.x - ((i+1) * (c_size.x))
					else:
						child_new_pos[child].x = get_rect().size.x - ((i+1) * (c_size.x + fit_separation + (fit_separation/(get_child_count()-1)))) + fit_separation
				ALIGNMENT.CENTER:
					var offset = _get_offset(fit_separation)
					if fit:
						offset -= fit_separation*0.5
						var value = offset + (i * (c_size.x + fit_separation + (fit_separation/(get_child_count()-1))))
						if is_nan(value):
							child_new_pos[child].x = offset
						else:
							child_new_pos[child].x = value
					else:
						child_new_pos[child].x = offset + (i * (c_size.x + fit_separation))
			child_new_pos[child].y = deck_center - c_size.y * 0.5
	
	if is_node_ready():
		if tween: tween.kill()
		tween = get_tree().create_tween()
		tween.set_ease(ease_type)
		tween.set_trans(transition_type)
		tween.tween_method(_tween_move_childs, 0.0, 1.0, speed_move)
	else:
		_tween_move_childs(1.0)

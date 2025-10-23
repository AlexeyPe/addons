extends Control
class_name APDragDataControl

@export var preview_self:bool = true
@export var remove_from_parent:bool = true
@export var enable_drag:VaRBool

var is_drag:bool = false
var parent_before_remove:Node
var index_before_remove:int

func _get_drag_data(at_position: Vector2) -> Variant:
	if enable_drag.value == false: return null
	is_drag = true
	if preview_self:
		var preview = self.duplicate(true)
		preview.set_meta("_drop_success", false)
		var _signal :Signal = preview.tree_exited
		_signal.connect(func():
			if is_drag:
				queue_free()
			elif parent_before_remove:
				parent_before_remove.add_child(self)
				position = preview.position
				parent_before_remove.move_child(self, index_before_remove)
				is_drag = false
			pass)
		set_drag_preview(preview)
	if remove_from_parent:
		parent_before_remove = get_parent()
		index_before_remove = get_index()
		parent_before_remove.remove_child(self)
	is_drag = true
	return self

extends Control

@export var drag_data:APDragDataRes

var is_drag:bool = false
var parent_before_remove:Node
var index_before_remove:int

func _get_drag_data(at_position: Vector2) -> Variant:
	if drag_data:
		is_drag = true
		drag_data.dragged_node = self
		if drag_data.preview_self:
			var preview = self.duplicate()
			var _signal :Signal = preview.tree_exited
			_signal.connect(func():
				if drag_data.success and is_drag:
					drag_data.success = false
					drag_data.dragged_node = null
				elif parent_before_remove:
					parent_before_remove.add_child(self)
					position = preview.position
					parent_before_remove.move_child(self, index_before_remove)
				is_drag = false
				pass)
			set_drag_preview(preview)
		if drag_data.remove_from_parent:
			parent_before_remove = get_parent()
			index_before_remove = get_index()
			parent_before_remove.remove_child(self)
		is_drag = true
	return drag_data

extends Resource
class_name APDragDataRes

@export var preview_self:bool = true
## Владелец этого ресурса будет [method Node.remove_child] у своего [method Node.get_parent] 
@export var remove_from_parent:bool = true

# Перетаскиваемый узел
var dragged_node:Control = null

var success:bool = false

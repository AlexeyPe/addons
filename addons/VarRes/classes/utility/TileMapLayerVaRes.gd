@tool
extends TileMapLayer
class_name TileMapLayerVaRes

@export var scene:PackedScene
@export var tile_offset:Vector2
@export var view_replace:bool = false : 
	set(new):
		view_replace = new
		self_modulate = Color(1.0, 1.0, 1.0, 1.0)
		clear_replace()
		if view_replace:
			self_modulate = MODULATE
			replace()

const MODULATE = Color(0.0, 0.0, 0.0, 0.0)

func clear_replace():
	for child in get_children():
		child.queue_free()
		pass
	pass

func update_tilemaplayer():
	pass

func replace():
	if !scene:
		printerr("TileMapLayerVaRes, scene is empty, ", get_path())
		return
	for cell in get_used_cells():
		var child:Node2D = scene.instantiate()
		child.position = cell * tile_set.tile_size
		child.position += tile_offset
		var data:TileData = get_cell_tile_data(cell)
		if data:
			var meta:VaRInt = child.get_meta("team_object")
			meta.set_value(data.get_custom_data("team_object"))
			var new_build = data.get_custom_data("build")
			if new_build != null and new_build is PackedScene:
				child.get_meta("field_build").value = new_build
		add_child(child)

func _ready() -> void:
	clear_replace()
	if Engine.is_editor_hint():
		if view_replace:
			replace()
			self_modulate = MODULATE
		return
	self_modulate = MODULATE
	replace()

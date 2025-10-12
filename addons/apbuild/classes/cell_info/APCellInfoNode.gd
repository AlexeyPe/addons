@tool
extends Node
class_name APCellInfoNode

@export var tilemaps:Array[TileMapLayer] :
	set(new):
		tilemaps = new
		if is_node_ready(): _update_cell_info_res()

@export var cell_info_res:APCellInfoRes :
	set(new):
		cell_info_res = new
		if is_node_ready(): _update_cell_info_res()

func _update_cell_info_res():
	if not cell_info_res: return
	var new_tilemaps:Array[TileMapLayer]
	for tilemap in tilemaps:
		if tilemap:
			new_tilemaps.append(tilemap)
	cell_info_res.tilemaps = new_tilemaps

func _ready() -> void:
	_update_cell_info_res()

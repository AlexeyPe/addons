@tool
extends Node2D
class_name APBuildManager2D 

@export var cell_size_px:int = 32
## Каждый [TileMapLayer] это данные игрока или игроков.[br]
## Этот [TileMapLayer] - это место где игрок может строить.
@export var can_build_player:Array[TileMapLayer]
## Информация о клетке собирается с каждого элемента массива
@export var cell_info:Array[TileMapLayer]


#func _ready() -> void:
	#if Engine.is_editor_hint():
		#set_process(false)
#
#var global_mouse_position:Vector2
#
#func _process(delta: float) -> void:
	#if global_mouse_position != get_global_mouse_position(): 
		#global_mouse_position = get_global_mouse_position()
		##print(tilemap.local_to_map(tilemap.to_local(global_mouse_position)))
		##print(get_global_mouse_position())
		##print(Vector2(
			##int(get_global_mouse_position().x)/cell_size_px,
			##int(get_global_mouse_position().y)/cell_size_px
		##))

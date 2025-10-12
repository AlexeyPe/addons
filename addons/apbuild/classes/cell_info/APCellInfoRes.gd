extends Resource
class_name APCellInfoRes

enum FIND_MODE {
	RECTANGLE,
	STAR,
	CIRCLE
}

@export var tile_size:Vector2i = Vector2i(48, 48)
@export_group("Check")
@export var check_tile_size:bool = false
@export_storage var tilemaps:Array[TileMapLayer] : 
	set(new):
		tilemaps = new
		if tilemaps.is_empty(): return
		if check_tile_size:
			for tilemap in tilemaps:
				prints(tilemap, "tile_size", tilemap.tile_set.tile_size)
				if tile_size != tilemap.tile_set.tile_size:
					push_error(
						"APCellInfoRes tilemaps.tile_size are different. 
						tilemap:%s, tile_size:%s, need tile_size:%s"%[
							tilemap, tilemap.tile_set.tile_size, tile_size
						]
					)

class Tag:
	var tilemap:TileMapLayer
	var id:int
	var alt_id:int
	func _init(tilemap:TileMapLayer, id:int, alt_id:int) -> void:
		self.tilemap = tilemap
		self.id = id
		self.alt_id = alt_id

class Cell:
	## Координаты ячейки
	var coords:Vector2i
	## Теги ячейки (это ячейки на разных TileMapLayer)
	var tags:Array[Tag]
	## Добавление тега
	func append_tag(tag:Tag):
		tags.append(tag)
	func is_empty() -> bool: return tags.is_empty()
	func _init(coords:Vector2i) -> void:
		self.coords = coords

func get_by_pos(position:Vector2) -> Cell:
	return get_by_coords(pos_to_coords(position))

func pos_to_coords(position:Vector2) -> Vector2i:
	return Vector2i(position/Vector2(tile_size))

func get_by_coords(coords:Vector2i) -> Cell:
	var cell: Cell = Cell.new(coords)
	for tilemap in tilemaps:
		var id:int = tilemap.get_cell_source_id(coords)
		if id > -1:
			cell.append_tag(Tag.new(
				tilemap, id, tilemap.get_cell_alternative_tile(coords)
			))
	return cell

func get_around_by_pos(
	center:Vector2i, radius:int = 1, mode=FIND_MODE.CIRCLE, incude_center:bool = false
) -> Array[Cell]:
	return get_around_by_coords(pos_to_coords(center), radius, mode, incude_center)

func get_around_by_coords(
	center:Vector2i, radius:int = 1, mode=FIND_MODE.CIRCLE, incude_center:bool = false
) -> Array[Cell]:
	var cells: Array[Cell]
	for coords in get_coords_in_radius(center, radius, mode, incude_center):
		var cell:Cell = get_by_coords(coords)
		if not cell.is_empty(): 
			cells.append(cell)
	return cells

func get_coords_in_radius(
	center:Vector2, radius:int, mode=FIND_MODE.RECTANGLE, incude_center:bool = false
) -> Array[Vector2i]:
	var result:Array[Vector2i] = []
	
	# Проходим по возможному диапазону смещения
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			# Проверка наличия клетки на карте
			var neighbor_pos:Vector2i = Vector2i(center.x + x, center.y + y)
			# Выбор типа проверки в зависимости от режима
			match mode:
				FIND_MODE.RECTANGLE:
					# Квадратный диапазон (все клетки в прямоугольнике)
					if abs(x) <= radius && abs(y) <= radius:
						result.append(neighbor_pos)      
				FIND_MODE.STAR:
					# Крестообразный диапазон ("звезда")
					if (abs(x) == abs(y)) or (x == 0) or (y == 0):
						result.append(neighbor_pos)
				FIND_MODE.CIRCLE:
					# Круглый диапазон (клетки внутри круга)
					if sqrt(float(x * x + y * y)) <= float(radius):
						result.append(neighbor_pos)
	if not incude_center:
		result.erase(center)
	return result

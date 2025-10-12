extends TileMapLayer

enum FIND_MODE {
	RECTANGLE,
	STAR,
	CIRCLE
}

func get_neighbor_cells_in_radius(tile_map, center, radius, mode=FIND_MODE.RECTANGLE, incude_center:bool = false):
	var result = []
	
	# Проходим по возможному диапазону смещения
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			# Проверка наличия клетки на карте
			var neighbor_pos = Vector2(center.x + x, center.y + y)
			# Выбор типа проверки в зависимости от режима
			match mode:
				FIND_MODE.RECTANGLE:
					# Квадратный диапазон (все клетки в прямоугольнике)
					if abs(x) <= radius && abs(y) <= radius:
						if tile_map.get_cell_source_id(neighbor_pos) > -1:
							result.append(neighbor_pos)      
				FIND_MODE.STAR:
					# Крестообразный диапазон ("звезда")
					if (abs(x) == abs(y)) or (x == 0) or (y == 0):
						if tile_map.get_cell_source_id(neighbor_pos) > -1:
							result.append(neighbor_pos)
				FIND_MODE.CIRCLE:
					# Круглый диапазон (клетки внутри круга)
					if sqrt(float(x * x + y * y)) <= float(radius):
						if tile_map.get_cell_source_id(neighbor_pos) > -1:
							result.append(neighbor_pos)
	if not incude_center:
		result.erase(center)
	return result

#func get_neighbor_cells_in_radius(tile_map:TileMapLayer, cell_position, radius):
	#var result = []
	#
	## Обход всех возможных смещений внутри радиуса
	#for x in range(-radius, radius + 1):
		#for y in range(-radius, radius + 1):
			#if abs(x) <= radius and abs(y) <= radius:
				## Рассчитываем позицию соседней клетки относительно исходной
				#var neighbor_pos = Vector2(cell_position.x + x, cell_position.y + y)
				#if tile_map.get_cell_source_id(neighbor_pos) > -1:
					#result.append(neighbor_pos)
	#return result

func _ready() -> void:
	# Координаты центральной клетки
	var center_cell = Vector2(3, 3)
	# Радиус поиска соседей
	var radius = 3
	var neighbors = get_neighbor_cells_in_radius(self, center_cell, radius, FIND_MODE.CIRCLE)
	for pos in neighbors:
		set_cell(pos, -1)
		#print(pos)

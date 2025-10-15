shader_type canvas_item;

uniform vec4 block_color : source_color;   // Цвет блока
uniform float block_width : hint_range(0.0, 1.0); // Ширина блока относительно холста
uniform float triangle_size_pixels : hint_range(1.0, 100.0); // Размер треугольников вдоль границы
uniform float wave_offset : hint_range(0.0, 1.0); // Смещение волны (от 0 до 1)

void fragment() {
    float triangle_size_uv = triangle_size_pixels * SCREEN_PIXEL_SIZE.y;
    
    // Проверяем находится ли пиксель внутри области блока
    if (UV.x >= block_width) { // Если вне основного блока
        float dist_from_edge = UV.x - block_width;
        float vert_pos_in_cycle = mod((UV.y + wave_offset * triangle_size_uv), triangle_size_uv);
        
        // Создаем форму треугольника
        float triangle_base = abs(vert_pos_in_cycle - triangle_size_uv / 2.0);
        
        // Отображаем только область внутри треугольника
        if (dist_from_edge > triangle_base) {
            discard; // Прозрачный фон вне треугольника
        }
    }
    
    // Все остальные пиксели окрашиваем цветом блока
    COLOR = block_color;
}
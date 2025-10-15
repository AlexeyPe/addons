shader_type canvas_item;

uniform vec4 block_color : source_color; // Основной цвет блоков
uniform float block_width : hint_range(0.0, 1.0); // Ширина основного блока (относительно размера холста)
uniform float triangle_size_pixels : hint_range(1.0, 100.0); // Размер треугольников (частота узоров)
uniform float wave_offset : hint_range(0.0, 1.0); // Смещение волновых периодов (от 0 до 1)


void fragment() {
	// Глобальная переменная для хранения размера треугольника в uv-пространстве
	float triangle_size_uv = triangle_size_pixels * SCREEN_PIXEL_SIZE.y;
    // Основная зона заполнена цветом блока
    if (UV.x < block_width || UV.y < block_width ||
        UV.x > 1.0 - block_width || UV.y > 1.0 - block_width) {
        // Периметры рисуются отдельными областями
        bool draw_left = UV.x <= block_width && UV.x > 0.0;
        bool draw_right = UV.x >= 1.0 - block_width && UV.x < 1.0;
        bool draw_top = UV.y <= block_width && UV.y > 0.0;
        bool draw_bottom = UV.y >= 1.0 - block_width && UV.y < 1.0;

        // Рисование левого края
        if (draw_left) {
            float y_position = mod(UV.y + wave_offset * triangle_size_uv, triangle_size_uv);
            float triangle_base = abs(y_position - triangle_size_uv / 2.0);
            if (UV.x >= block_width - triangle_base) {
                COLOR = block_color;
            } else {
                discard;
            }
        }
        // Рисование правого края
        else if (draw_right) {
            float y_position = mod(UV.y + wave_offset * triangle_size_uv, triangle_size_uv);
            float triangle_base = abs(y_position - triangle_size_uv / 2.0);
            if ((1.0 - UV.x) >= triangle_base) {
                COLOR = block_color;
            } else {
                discard;
            }
        }
        // Рисование верхнего края
        else if (draw_top) {
            float x_position = mod(UV.x + wave_offset * triangle_size_uv, triangle_size_uv);
            float triangle_base = abs(x_position - triangle_size_uv / 2.0);
            if (UV.y >= block_width - triangle_base) {
                COLOR = block_color;
            } else {
                discard;
            }
        }
        // Рисование нижнего края
        else if (draw_bottom) {
            float x_position = mod(UV.x + wave_offset * triangle_size_uv, triangle_size_uv);
            float triangle_base = abs(x_position - triangle_size_uv / 2.0);
            if ((1.0 - UV.y) >= triangle_base) {
                COLOR = block_color;
            } else {
                discard;
            }
        }
    } else {
        discard; // Все остальные пиксели остаются прозрачными
    }
}
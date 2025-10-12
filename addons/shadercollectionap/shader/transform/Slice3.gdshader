shader_type canvas_item;

// Параметры управления эффектом
uniform float split_position : hint_range(0.0, 1.0) = 0.5; // Центральная точка разреза
uniform float offset_amount : hint_range(-1.0, 1.0) = 0.5; // Величина смещения половинок друг от друга

void vertex() {
    // Текущие UV координаты вершины
    vec2 uv = VERTEX.xy / TEXTURE_PIXEL_SIZE;
    
    // Проверяем положение пикселя относительно центра разреза
    bool is_left_half = uv.x <= split_position;
    
    // Рассчитываем сдвиг вершин исходя из положения
    float shift = mix(offset_amount * -0.5, offset_amount * 0.5, step(split_position, uv.x));
    
    // Смещаем каждую половину в нужную сторону
    VERTEX += vec2(shift, 0.0);
}

void fragment() {
    // Оставляем рендер цвета обычным образом
    COLOR = texture(TEXTURE, UV);
}
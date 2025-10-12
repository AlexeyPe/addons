shader_type canvas_item;
render_mode unshaded;

uniform float grid_size = 10.0; // Размер ячейки сетки
uniform vec4 line_color : source_color = vec4(0.8); // Цвет линий

varying vec2 world_position;

void vertex(){
	// calculate the world position for use in the fragment shader
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
    // Определяем расстояние до ближайших границ сетки
    float dist_x = mod(world_position.x, grid_size);
    float dist_y = mod(world_position.y, grid_size);
    
    // Проверяем, находится ли точка близко к линии сетки
    bool is_line = abs(dist_x) <= 1.0 || abs(dist_y) <= 1.0;
    
    if (is_line) {
        COLOR = line_color;
    } else {
        discard; // Пропускаем точки вне линий сетки
    }
}
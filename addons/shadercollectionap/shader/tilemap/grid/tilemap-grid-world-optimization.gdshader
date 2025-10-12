shader_type canvas_item;
render_mode unshaded;

// Размер ячейки сетки
uniform float grid_size = 48.0;
// Цвет линий
uniform vec4 line_color : source_color = vec4(0.129, 0.129, 0.129, 0.157);
// Смещение сетки
uniform vec2 offset = vec2(24.0, 24.0);
// Толщина линий
uniform float line_thickness = 1.0;

const vec4 discardColor = vec4(0.0, 0.0, 0.0, 0.0); // Полностью прозрачный черный цвет
varying vec2 world_position;

void vertex(){
	// calculate the world position for use in the fragment shader
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy + offset;
}

void fragment() {
    // Определяем расстояние до ближайших границ сетки
    float dist_x = mod(world_position.x, grid_size);
    float dist_y = mod(world_position.y, grid_size);
	// Берём минимальное расстояние до ближайшего края сетки
    float d = min(abs(dist_x), abs(dist_y)); 
	vec4 lines = mix(discardColor, line_color, step(d, line_thickness));
	COLOR.rgb = mix(COLOR, lines, step(d, line_thickness)*lines.a).rgb;
}
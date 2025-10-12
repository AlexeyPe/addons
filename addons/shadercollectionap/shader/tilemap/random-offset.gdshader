shader_type canvas_item;

uniform vec2 offset = vec2(0.0, 0.25);
uniform float scale = 1.0;

void vertex() {
    // Применяем смещение к вершинам
    VERTEX += offset;
}

void fragment() {
	vec2 uv = UV * scale;

    if (uv.x > 1.0 || uv.y > 1.0) { // Обрезка пикселей вне текстуры
        discard;
    }

    COLOR *= texture(TEXTURE, uv);
}

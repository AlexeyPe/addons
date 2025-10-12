shader_type canvas_item;
// Скорость перемещения
uniform float interval = 0.5;
// Интенсивность
uniform vec2 intensity = vec2(20.0);
uniform float seed = 42.0;

void vertex() {
	float seedNum = VERTEX.x + VERTEX.y + floor(TIME / interval) + seed;
	vec2 offset = vec2(
		sin(seedNum * 12.9898) * 43758.5453,
		sin(seedNum * 32.9472) * 94726.0482
	);
	offset = fract(offset);
	VERTEX += offset * intensity;
}
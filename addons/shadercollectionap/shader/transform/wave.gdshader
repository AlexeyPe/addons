shader_type canvas_item;

uniform float speed = 2.0;
uniform float height = 44.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 test = texture(TEXTURE, UV+vec2(0, sin(TIME*speed+UV.x*12.5)/height));
	COLOR = test;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

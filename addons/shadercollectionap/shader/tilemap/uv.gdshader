shader_type canvas_item;

const vec2 local_uv[] = { vec2(0,0), vec2(0,1), vec2(1,1), vec2(1,0)};
varying vec2 LOCAL_UV;
void vertex() {
	LOCAL_UV = local_uv[VERTEX_ID];
}

void fragment() {
	COLOR = vec4(LOCAL_UV, 0.0, 1.0);
}

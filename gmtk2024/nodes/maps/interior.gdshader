shader_type spatial;

uniform bool should_render = false;

void fragment() {
	ALPHA = abs(sin(TIME));
	ALBEDO = vec3(1.0, 1.0, 1.0);
}

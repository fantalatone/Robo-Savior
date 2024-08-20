shader_type spatial;

render_mode ambient_light_disabled, specular_toon, cull_back;

uniform sampler2D t;
uniform vec3 color_albd = vec3(1, 1, 1);

void fragment() {
	vec4 color = texture(t, UV);
	
	ALBEDO = color.rgb * color_albd;
	//ALPHA = color.a;
}

void light() {
	// light we wish to accumulate
	DIFFUSE_LIGHT += ALBEDO * ATTENUATION * LIGHT_COLOR * max(dot(LIGHT, NORMAL), 0.0);

	// assign the result
	SPECULAR_LIGHT = round(DIFFUSE_LIGHT * 3.0 - 0.5) / 8.0; // posterizes the final color

	// cancel all contribution of the diffuse_light variable
	SPECULAR_LIGHT -= DIFFUSE_LIGHT;
}
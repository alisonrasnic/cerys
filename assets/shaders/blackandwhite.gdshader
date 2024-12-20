shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	vec3 screen_col = texture(TEXTURE, UV).rgb;
	float lum = (screen_col.r * 0.299) + (screen_col.g * 0.587) + (screen_col.b * 0.114);
	if (lum <= 0.0) {
		COLOR.rgba = vec4(255.0, 1.0, 1.0, 1.0);
	} else {
		COLOR.rgba = vec4(255.0, 1.0, 1.0, 1.0);
	}
	COLOR.rgba = vec4(1.0, 1.0, 1.0, 1.0);
}


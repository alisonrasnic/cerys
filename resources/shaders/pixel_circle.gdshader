shader_type canvas_item;

const vec2 offset = vec2(-0.485,-0.485);

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.rgba = vec4(0,0,0,0);
	float circle_radius = 0.5;
	
	vec2 uv = floor((UV)/TEXTURE_PIXEL_SIZE)*TEXTURE_PIXEL_SIZE;
	vec4 color = texture(screen_texture, uv);
	color.rgba = vec4(1,1,1,1);
	
	if (pow(uv.x + offset.x, 2) + pow(uv.y + offset.y, 2) <= pow(circle_radius,2))
		COLOR = color;
}


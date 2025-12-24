shader_type canvas_item;

uniform float tolerance_1 : hint_range(0.0, 1.0, 0.01) = 0.1;
uniform vec4 prev_color_1 : source_color = vec4(1.0);
uniform vec4 new_color_1  : source_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform float tolerance_2 : hint_range(0.0, 1.0, 0.01) = 0.1;
uniform vec4 prev_color_2 : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 new_color_2  : source_color = vec4(1.0, 0.0, 0.0, 1.0);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 initial_color = color;

	// --- First color replacement ---
	float dist1 = distance(prev_color_1.rgb, color.rgb);
	if (dist1 <= tolerance_1) {
		color.rgb = mix(new_color_1.rgb, color.rgb, dist1 / tolerance_1);
	}

	// --- Second color replacement ---
	float dist2 = distance(prev_color_2.rgb, color.rgb);
	if (dist2 <= tolerance_2) {
		color.rgb = mix(new_color_2.rgb, color.rgb, dist2 / tolerance_2);
	}

	// Preserve original alpha
	color.a = initial_color.a;
	COLOR = color;
}

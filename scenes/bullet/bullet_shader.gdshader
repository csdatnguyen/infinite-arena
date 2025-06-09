shader_type canvas_item;

uniform float outline_width = 1.5;	// thickness of outline
uniform vec4 outline_color = vec4(0.0, 0.0, 0.0, 1.0);	// outline color

void fragment() {
    vec2 uv = UV;
    vec4 tex_color = texture(TEXTURE, uv);
    float alpha = tex_color.a;

    float edge = 0.0;

	// If the current pixel is mostly transparent, it might be on the edge
    if (alpha < 0.1) {
        vec2 tex_size = vec2(textureSize(TEXTURE, 0));

		// Loop through neighboring pixels
        for (float x = -1.0; x <= 1.0; x++) {
            for (float y = -1.0; y <= 1.0; y++) {
                vec2 offset_uv = uv + vec2(x, y) * outline_width / tex_size;
				
				// If any neighbor is not transparent, this pixel borders the shape
                if (texture(TEXTURE, offset_uv).a > 0.1) {
                    edge = 1.0;
                }
            }
        }

		// If we're on an edge, draw the outline color; otherwise, skip rendering
        if (edge > 0.0) {
            COLOR = outline_color;
        } 
		else {
            discard;
        }
    } 
	else {
        COLOR = tex_color;
        COLOR.a = alpha;
    }
}

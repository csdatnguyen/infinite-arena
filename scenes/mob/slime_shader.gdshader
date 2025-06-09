shader_type canvas_item;

uniform vec4 base_tint_color : source_color = vec4(1.0, 1.0, 1.0, 1.0); // white
uniform float tint_strength = 0.0; // 0 = no tint, 1 = full tint

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Gently tint the original sprite
    vec4 tinted_color = mix(tex_color, base_tint_color, tint_strength);

	COLOR = tinted_color;

    // Preserve transparency
    COLOR.a = tex_color.a;
}
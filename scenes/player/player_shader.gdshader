shader_type canvas_item;

uniform float flash_amount = 0.0;
uniform vec4 flash_color : source_color = vec4(0.4, 0.0, 0.0, 1.0); // flash red on hit
uniform vec4 player_color : source_color = vec4(1.0, 0.7, 0.4, 1.0);  // base orange tint

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Setting base color of the player
    vec4 base_color = tex_color * player_color;

    // Pulsing intensity using time
    float glow_strength = abs(sin(TIME * 20.0)); // 0 to 1, fast pulse

    // Pulsing red glow based on flash color
    vec4 flash_glow = flash_color * glow_strength;

    // If flashing, override with pulsing glow; otherwise, use base color
    if (flash_amount > 0.0) {
        COLOR = flash_glow;
    } 
	else {
        COLOR = base_color;
    }

    // Preserve transparency
    COLOR.a = tex_color.a;
}

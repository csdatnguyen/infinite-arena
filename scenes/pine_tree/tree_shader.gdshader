shader_type canvas_item;

//uniform float outline_width = 1.5;
//uniform vec4 outline_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform float sway_strength = 0.02; // How far it sways (UV offset)
uniform float sway_speed = 4.0;     // How fast it sways
uniform float sway_frequency = 1.0; // Number of waves across the X axis

void fragment() {
    vec2 sway_uv = UV;
    
    // Apply sine wave distortion to create sway (moves side to side)
    sway_uv.x += sin(UV.y * sway_frequency + TIME * sway_speed) * sway_strength;

    vec4 tex_color = texture(TEXTURE, sway_uv);
    float alpha = tex_color.a;
	
   	COLOR = tex_color;
    COLOR.a = alpha;
	
    //float edge = 0.0;
//
    //if (alpha < 0.1) {
        //vec2 tex_size = vec2(textureSize(TEXTURE, 0));
        //for (float x = -1.0; x <= 1.0; x++) {
            //for (float y = -1.0; y <= 1.0; y++) {
                //vec2 offset_uv = sway_uv + vec2(x, y) * outline_width / tex_size;
                //if (texture(TEXTURE, offset_uv).a > 0.1) {
                    //edge = 1.0;
                //}
            //}
        //}
//
        //if (edge > 0.0) {
            //COLOR = outline_color;
        //} else {
            //discard;
        //}
    //} else {
        //COLOR = tex_color;
        //COLOR.a = alpha;
    //}
}

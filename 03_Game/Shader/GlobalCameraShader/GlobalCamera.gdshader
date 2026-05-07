shader_type canvas_item;
render_mode unshaded;

// 发光参数
uniform vec4 glow_color : source_color = vec4(1, 1.0, 1.0, 1.0);
uniform float glow_strength : hint_range(0.0, 5.0) = 2.0;
uniform float pulse_speed : hint_range(0.0, 3.0) = 1.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = tex_color;
    
    // 呼吸效果（可选，删掉就不呼吸）
    float pulse = sin(TIME * pulse_speed) * 0.3 + 0.7;
    
    // 把原图的颜色作为发光强度，直接叠加到颜色上
    COLOR.rgb += tex_color.rgb * glow_color.rgb * glow_strength * pulse * tex_color.a;
}
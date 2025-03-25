shader_type canvas_item;

uniform sampler2D textura_pantalla : hint_screen_texture, filter_linear_mipmap;
uniform float cantidad : hint_range(0.0, 5.0);

void fragment() {
	COLOR.rgb = textureLod(textura_pantalla, SCREEN_UV, cantidad).rgb;
}
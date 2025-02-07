shader_type canvas_item;

void vertex() {
	VERTEX.y += sin(TIME * 30.0);
}

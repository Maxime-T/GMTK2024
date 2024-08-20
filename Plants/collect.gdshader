shader_type spatial;
void vertex() {
	VERTEX += NORMAL/10000.;
	
}

void fragment() {
	//ALBEDO = vec3(sin(VERTEX.y*20.-TIME*2.));
	ALBEDO = vec3(UV.x,UV.x,UV.x);
	//ALPHA = max(0,sin(VERTEX.y*20.-TIME*2.));
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

shader_type spatial;
render_mode unshaded, cull_front;
uniform bool enabled;

void vertex() {
	UV.x = VERTEX.x;
	UV.y = VERTEX.y;
	
	VERTEX += NORMAL * 0.0006;
	
}

void fragment() {
	if (enabled) {
		ALPHA = clamp((sin((UV.y+UV.x)*10.-TIME*4.)-0.8)/(1.-0.8), 0., 1.);
		ALBEDO = vec3(2.7,2.7,2.7);
	} else {
		ALPHA = 0.;
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}

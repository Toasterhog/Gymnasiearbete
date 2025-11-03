shader_type spatial;
render_mode unshaded;

// Converts HSV (all in 0–1 range) to RGB (also 0–1) from GPT
vec3 hsv2rgb(vec3 c) {
    float h = c.x; // hue in [0,1]
    float s = c.y; // saturation in [0,1]
    float v = c.z * c.z *c.z; // value in [0,1]

    float h6 = h * 6.0;
    float i = floor(h6);
    float f = h6 - i;

    float p = v * (1.0 - s);
    float q = v * (1.0 - f * s);
    float t = v * (1.0 - (1.0 - f) * s);

    vec3 rgb;

    if (i == 0.0)
        rgb = vec3(v, t, p);
    else if (i == 1.0)
        rgb = vec3(q, v, p);
    else if (i == 2.0)
        rgb = vec3(p, v, t);
    else if (i == 3.0)
        rgb = vec3(p, q, v);
    else if (i == 4.0)
        rgb = vec3(t, p, v);
    else
        rgb = vec3(v, p, q);

    return rgb;
}

void vertex() {
	COLOR.xz = VERTEX.xz; // -1 to 1
	COLOR.y = 0.5 + VERTEX.y /2.0; // 0 to 1
}

void fragment() {
	//atan outputs -pi to pi
	float hue = atan(-COLOR.z, COLOR.x) / (2.0 * PI);
	if (hue < 0.0){hue += 1.0;}
	float saturation = distance(vec2(COLOR.z, COLOR.x), vec2(0,0));
	float value = COLOR.y;
	ALBEDO.rgb = hsv2rgb(vec3(hue, saturation, value));
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

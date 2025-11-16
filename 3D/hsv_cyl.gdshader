shader_type spatial;
render_mode unshaded;

// Converts HSV (all in 0–1 range) to RGB (also 0–1) from GPT
vec3 hsv2rgb(vec3 c) {
    float h = c.x; // hue in [0,1]
    float s = c.y; // saturation in [0,1]
    float v = c.z ;//* c.z *c.z; // value in [0,1]

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

vec3 srgb_to_linear(vec3 c) {
    // piecewise per-channel:
    vec3 less = c / 12.92;
    vec3 more = pow((c + vec3(0.055)) / vec3(1.055), vec3(2.4));
    // step returns 0.0 if x < edge, 1.0 if x >= edge — works per component
    return mix(less, more, step(vec3(0.04045), c));
}

vec3 linear_to_srgb(vec3 c) {
    vec3 less = c * 12.92;
    vec3 more = vec3(1.055) * pow(c, vec3(1.0 / 2.4)) - vec3(0.055);
    return mix(less, more, step(vec3(0.0031308), c));
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
	value = value*value;
	ALBEDO.rgb = srgb_to_linear(hsv2rgb(vec3(hue, saturation, value)));
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

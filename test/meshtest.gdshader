shader_type spatial;
render_mode unshaded;

// Simple HSL → RGB
vec3 hsl2rgb(vec3 hsl) {
	float h = hsl.x;
	float s = hsl.y;
	float l = hsl.z;

	float c = (1.0 - abs(2.0*l - 1.0)) * s;
	float h6 = h * 6.0;
	float x = c * (1.0 - abs(mod(h6,2.0) - 1.0));
	vec3 rgb1;

	if (0.0 <= h6 && h6 < 1.0) rgb1 = vec3(c,x,0);
	else if (1.0 <= h6 && h6 < 2.0) rgb1 = vec3(x,c,0);
	else if (2.0 <= h6 && h6 < 3.0) rgb1 = vec3(0,c,x);
	else if (3.0 <= h6 && h6 < 4.0) rgb1 = vec3(0,x,c);
	else if (4.0 <= h6 && h6 < 5.0) rgb1 = vec3(x,0,c);
	else rgb1 = vec3(c,0,x);

	float m = l - 0.5*c;
	return rgb1 + vec3(m);
}

vec3 srgb_to_linear(vec3 c) {
    // piecewise per-channel:
    vec3 less = c / 12.92;
    vec3 more = pow((c + vec3(0.055)) / vec3(1.055), vec3(2.4));
    // step returns 0.0 if x < edge, 1.0 if x >= edge — works per component
    return mix(less, more, step(vec3(0.04045), c));
}

void vertex() {
	// store local position in COLOR for interpolation
	COLOR.rgb = VERTEX.rgb;
}

void fragment() {
	vec3 p = COLOR.rgb;

	// Map Y to lightness 0..1
	float l = (p.y + 1.0)/2.0;

	// Hue based on XZ-plane angle
	float hue = atan(p.z, p.x)/(2.0*PI);
	if (hue < 0.0) hue += 1.0;

	// Saturation based on radial distance
	float s = length(p.xz);

	ALBEDO = srgb_to_linear(hsl2rgb(vec3(hue,s,l)));
}

extends Node

func position_to_hsv(pos: Vector3) -> Vector3:
	var x = pos.x
	var y = pos.y
	var z = pos.z

	# Convert position to HSV-like values (based on your shader)
	var hue = atan2(-z, x) / TAU
	if hue < 0.0:
		hue += 1.0

	var saturation = sqrt(x * x + z * z)

	var value = (0.5 + y / 2.0)  # Matches vertex() mapping for COLOR.y
	value = value * value# * value  # Matches v = c.z * c.z * c.z

	# Convert HSV to RGB (exact matching shader logic)
	return  Vector3(hue, saturation, value) #Color.from_hsv(hue, saturation, value)

func hsv_to_rgb(vec : Vector3) -> Color:
	var h = vec.x
	var s = vec.y
	var v = vec.z #* vec.z * vec.z
	
	var h6 = h * 6.0
	var i = int(floor(h6))
	var f = h6 - i

	var p = v * (1.0 - s)
	var q = v * (1.0 - f * s)
	var t = v * (1.0 - (1.0 - f) * s)

	var r: float
	var g: float
	var b: float

	match i % 6:
		0:
			r = v; g = t; b = p
		1:
			r = q; g = v; b = p
		2:
			r = p; g = v; b = t
		3:
			r = p; g = q; b = v
		4:
			r = t; g = p; b = v
		_:
			r = v; g = p; b = q
	return Color(r, g, b)

func rgb_to_hsv(rgb):
	pass

func hsv_to_position(hsv):
	pass

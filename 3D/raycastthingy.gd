extends Node3D
@onready var camera_3d: Camera3D = $"../Camera3D"


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var in_po = raycast(get_viewport().get_mouse_position())
		if in_po:
			print("ma a mariao")
			var marker = CSGSphere3D.new()
			marker.radius = 0.05
			marker.radial_segments = 7
			marker.rings = 4
			marker.material = load("res://marker_material.tres").duplicate()
			marker.material.set_albedo(position_to_color(in_po))
			marker.position = in_po
			get_viewport().add_child(marker)
		

func raycast(mouse_pos):
	#var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera_3d.project_ray_origin(mouse_pos)
	var ray_direction = camera_3d.project_ray_normal(mouse_pos)
	var param = PhysicsRayQueryParameters3D.create(ray_origin, ray_origin + ray_direction * 100)
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(param)
	if result:
		var intersect_position = result.position
		print("Hit at: ", position)
		return intersect_position
	else:
		print("No hit")
		return


func position_to_color(pos: Vector3) -> Color:
	var x = pos.x
	var y = pos.y
	var z = pos.z

	# Convert position to HSV-like values (based on your shader)
	var hue = atan2(-z, x) / TAU
	if hue < 0.0:
		hue += 1.0

	var saturation = sqrt(x * x + z * z)

	var value = (0.5 + y / 2.0)  # Matches vertex() mapping for COLOR.y
	value = value * value * value  # Matches v = c.z * c.z * c.z

	# Convert HSV to RGB (exact matching shader logic)
	return hsv_to_rgb(hue, saturation, value)


func hsv_to_rgb(h: float, s: float, v: float) -> Color:
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

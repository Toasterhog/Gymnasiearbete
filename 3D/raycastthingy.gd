extends Node3D
@onready var camera_3d: Camera3D = $"../Camera3D"
@onready var hub: Hub = $"../Hub"

#signal ColorClick(color : Color)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var in_po = raycast(get_viewport().get_mouse_position()) #(intersection point)
		if in_po:
			print("hit volume")
			var sd_referance = hub.add_swatch()
			var hsv = AutoloadTransFuncs.position_to_hsv(in_po)
			var col = Color.from_hsv(hsv.x, hsv.y, hsv.z)#.linear_to_srgb()
			hub.update_swatch(sd_referance, col)
			
			#var marker = CSGSphere3D.new()
			#marker.radius = 0.05
			#marker.radial_segments = 7
			#marker.rings = 4
			#marker.material = load("res://3D/new_shader_material.tres").duplicate()
			#var hsv = AutoloadTransFuncs.position_to_hsv(in_po)
			#var col = Color.from_hsv(hsv.x, hsv.y, hsv.z)#.linear_to_srgb()
			#marker.material.set_shader_parameter("col", col)
			#marker.position = in_po
			#get_viewport().get_child(0).add_child(marker)
			#ColorClick.emit(col)
			

func raycast(mouse_pos):
	#var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = camera_3d.project_ray_origin(mouse_pos)
	var ray_direction = camera_3d.project_ray_normal(mouse_pos)
	var param = PhysicsRayQueryParameters3D.create(ray_origin, ray_origin + ray_direction * 100)
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(param)
	if result:
		var intersect_position = result.position
		return intersect_position					#reparent marker_holder to toggle raycast be able to hit markers, if shift then select markers, can be other raycastfunc, then be able to change pos by use colorpicker
	else:
		return

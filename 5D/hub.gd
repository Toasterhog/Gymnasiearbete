extends Node
class_name Hub

@export var pallet_window : Node

var swatches_array : Array
var fokused : swatch_data

#func add_swatch_from_color(c : Color):
	#var square = Swatch.new()
	#square.color = c
	#pallet_window.add_child(square)
#
	#
	#var marker = CSGSphere3D.new()
	#marker.radius = 0.05
	#marker.radial_segments = 7
	#marker.rings = 4
	#marker.material = load("res://3D/new_shader_material.tres").duplicate()
	#marker.material.set_shader_parameter("col", c)
	#marker.position = AutoloadTransFuncs.hsv_to_position(AutoloadTransFuncs.rgb_to_hsv(c))
	#get_viewport().get_child(0).add_child(marker)
	#
	#var data = swatch_data.new()
	#data.color = c
	#data.square_node = square

#func add_swatch_from_position(pos : Vector3):
	#var data = swatch_data.new()
	#data.color = c
	#
	#var square = Swatch.new()
	#square.color = c
	#square.square_node = sq
	#
	#var marker = CSGSphere3D.new()
	#marker.radius = 0.05
	#marker.radial_segments = 7
	#marker.rings = 4
	#marker.material = load("res://3D/new_shader_material.tres").duplicate()
	#var hsv = position_to_hsv(in_po)
	#var col = Color.from_hsv(hsv.x, hsv.y, hsv.z)#.linear_to_srgb()
	#marker.material.set_shader_parameter("col", col)
	#marker.position = in_po
	#get_viewport().get_child(0).add_child(marker)
	#ColorClick.emit(col)
	#markers.set(col, marker)

func add_swatch() -> swatch_data:
	var data = swatch_data.new()
	var square = Swatch.new()
	var marker = CSGSphere3D.new()
	
	square.sd = data
	square.square_LMB.connect(pallet_window.q_lmb)
	square.square_RMB.connect(pallet_window.q_rmb)
	pallet_window.add_swatch(square)
	
	marker.radius = 0.05
	marker.radial_segments = 7
	marker.rings = 4
	marker.material = load("res://3D/new_shader_material.tres").duplicate()
	get_viewport().get_child(0).add_child(marker)
	
	data.square_node = square
	data.marker_node = marker
	swatches_array.append(data)
	return data

func update_swatch(dat: swatch_data, c: Color):
	dat.color = c
	dat.square_node.color = c
	dat.marker_node.material.set_shader_parameter("col", c)
	dat.marker_node.position = AutoloadTransFuncs.hsv_to_position(AutoloadTransFuncs.rgb_to_hsv(c)) #CAUTION not implemented
	
func remove_swatch(dat : swatch_data):
	dat.square_node.queue_free()
	dat.marker_node.queue_free()
	swatches_array.erase(dat)
	#dat.free()

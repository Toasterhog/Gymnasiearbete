extends Node3D
@export var csg_mesh_3d: CSGMesh3D


func _ready() -> void:
	csg_mesh_3d.set_mesh(make())



func make() -> Mesh:
	var v = PackedVector3Array([
		Vector3(0,  1,   0),         # 0  top
		Vector3(0.5,  0.5,  -0.8660254),   # 6
		Vector3(1,     -0.5,   0),           # 1
		Vector3(0.5,  0.5,   0.8660254),   # 2
		Vector3(-0.5,  -0.5,   0.8660254),   # 3
		Vector3(-1,   0.5,   0),           # 4
		Vector3(-0.5,  -0.5,  -0.8660254),   # 5
		

		Vector3(0, -1, 0)           # 7  bottom
	])

	var ind = PackedInt32Array([
		# --- TOP (3 faces), CCW when looking DOWN at the top ---
		1, 3, 0,
		3, 5, 0,
		5, 1, 0,

		# --- BOTTOM (3 faces), CCW when looking UP at the bottom ---
		2, 7, 4,
		4, 7, 6,
		6, 7, 2,

		# --- BELT (6 faces), CCW from outside ---
		1, 2, 3,
		3, 2, 4,
		3, 4, 5,
		5, 4, 6,
		5, 6, 1,
		1, 6, 2
	])

	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = v
	arrays[Mesh.ARRAY_INDEX] = ind

	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh
#
#func make():
	#var verts = PackedVector3Array([
		#Vector3(0,  1,   0),                     # 0  top
#
		#Vector3(1,    0.5,   0),                 # 1
		#Vector3(0.5, -0.5,  0.8660254),          # 2
		#Vector3(-0.5, 0.5,  0.8660254),          # 3
		#Vector3(-1,  -0.5,  0),                  # 4
		#Vector3(-0.5, 0.5, -0.8660254),          # 5
		#Vector3(0.5, -0.5, -0.8660254),          # 6
#
		#Vector3(0, -1, 0)                        # 7  bottom
	#])
#
	## Triangles
	#var ind = PackedInt32Array()
#
	## Top cap (6 triangles)
	#for i in range(1, 7):
		#ind.append_array([0, i, i % 6 + 1])
#
	## Middle band (12 triangles)
	#for i in range(6):
		#var a = 1 + i
		#var b = 1 + ((i + 1) % 6)
		#var c = 1 + ((i + 2) % 6)
		#ind.append_array([a, b, c])
		#ind.append_array([a, c, 1 + ((i + 3) % 6)])
#
	## Bottom cap (6 triangles)
	#for i in range(6):
		#ind.append_array([7, 1 + ((i + 1) % 6), 1 + i])
#
	#var arrays = []
	#arrays.resize(Mesh.ARRAY_MAX)
	#arrays[Mesh.ARRAY_VERTEX] = verts
	#arrays[Mesh.ARRAY_INDEX] = ind
#
	#var mesh = ArrayMesh.new()
	#mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	#
	#return mesh

#func make():
	#var vertices = PackedVector3Array()
	#vertices.push_back(Vector3(0, 1, 0))
	#vertices.push_back(Vector3(1, 0, 0))
	#vertices.push_back(Vector3(0, 0, 1))
#
	## Initialize the ArrayMesh.
	#var arr_mesh = ArrayMesh.new()
	#var arrays = []
	#arrays.resize(Mesh.ARRAY_MAX)
	#arrays[Mesh.ARRAY_VERTEX] = vertices
#
	## Create the Mesh.
	#arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	#
	#var m = MeshInstance3D.new()
	#m.mesh = arr_mesh
	#add_child(m)

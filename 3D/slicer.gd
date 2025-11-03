extends CSGBox3D

@onready var camera: Camera3D = $"../../../Camera3D"
var d = 0
var depth_delta = 0.2
var transforming = true
@onready var clampdist = Vector2(2*camera.r - 3, 2*camera.r +3)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_slice_transforming"):
		transforming = !transforming
		updatepos()
	if transforming: #change depth
		if event is InputEventMouseButton and event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				d += depth_delta
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				d -= depth_delta
			depth()
		if Input.is_action_pressed("more_depth"):
			d += depth_delta
			depth()
		if Input.is_action_pressed("less_depth"):
			d -= depth_delta
			depth()

func depth():
	d = clampf(d, clampdist.x, clampdist.y)
	size.z = d

func updatepos():
	if transforming:
		basis = camera.basis
		position = camera.position

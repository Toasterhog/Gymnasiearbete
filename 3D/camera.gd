extends Camera3D

var phi : float = 0
var theta : float = 0
var r : float = 3
var sensitivity : float = 0.01
@onready var csg_box: CSGBox3D = $"../CSGCombiner3D/CSGCylinder3D/CSGBox3D"


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("pan"):
		phi = fmod(phi - event.relative.x * sensitivity, 2*PI)
		theta = clamp( theta + event.relative.y * sensitivity, -PI/2, PI/2)
		updatepos()
	

func updatepos():
	position.x = r * cos(phi) * cos(theta)
	position.y = r * sin(theta)
	position.z = r * -sin(phi) * cos(theta)
	
	rotation = Vector3(-theta, phi +PI/2, 0)
	
	csg_box.updatepos()

extends Node3D
@onready var raycastthingy: Node3D = $raycastthingy
@onready var swatshes: Panel = $CanvasLayer/Control/swatshes

func _ready() -> void:
	raycastthingy.ColorClick.connect(swatshes.add_swatch)

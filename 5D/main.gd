extends Node3D
@onready var raycastthingy: Node3D = $raycastthingy
@onready var pallet_window: Panel = $CanvasLayer/Control/pallet_window

func _ready() -> void:
	raycastthingy.ColorClick.connect(pallet_window.add_swatch)

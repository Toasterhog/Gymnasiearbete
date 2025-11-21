extends ColorRect
class_name Swatch

signal square_LMB(sw)
signal square_RMB(sd)

var sd : swatch_data

func _ready() -> void:
	custom_minimum_size = Vector2(20,20)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and sd:
		if event.button_index == MOUSE_BUTTON_LEFT:
			square_LMB.emit(sd)
		if event.button_index == MOUSE_BUTTON_RIGHT:
			square_RMB.emit(sd)

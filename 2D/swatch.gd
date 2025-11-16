extends ColorRect
class_name Swatch


func _ready() -> void:
	custom_minimum_size = Vector2(20,20)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			var c = color.to_html(false)
			DisplayServer.clipboard_set(c)
			$"../../../HBoxContainer/LineEdit".text = "#" + c
			var textcol = Color.BLACK if color.r + color.g + color.r > 2.5 else Color.WHITE
			$"../../../HBoxContainer/LineEdit".add_theme_color_override("font_uneditable_color", textcol)
			var styl : StyleBoxFlat = load("res://2D/style/swatshes_LE.tres")
			styl.bg_color = c
			styl.border_color = c
		if event.button_index == MOUSE_BUTTON_RIGHT:
			queue_free()
			var kid = get_viewport().get_child(0).get_node("raycastthingy").markers.get(color)
			if kid:
				kid.queue_free()
				get_viewport().get_child(0).get_node("raycastthingy").markers.erase(color)

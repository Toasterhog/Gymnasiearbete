extends Panel
@onready var hbc: HBoxContainer = $ScrollContainer/SwatchContainer
@onready var line_edit: LineEdit = $HBoxContainer/LineEdit
@onready var hub: Hub = $"../../../Hub"

func add_swatch(n : Node):
	hbc.add_child(n)
	hbc.move_child(n, 0)


func resize(b):
	if not b: #size.x > 240:
		size.x = 230
	else:
		size.x = 520


func q_lmb(sd) -> void:
	var color = sd.color
	var c = color.to_html(false)
	DisplayServer.clipboard_set(c)
	line_edit.text = "#" + c
	var textcol = Color.BLACK if color.r + color.g + color.r > 2.5 else Color.WHITE
	line_edit.add_theme_color_override("font_uneditable_color", textcol)
	var styl : StyleBoxFlat = load("res://2D/style/swatshes_LE.tres")
	styl.bg_color = c
	styl.border_color = c

func q_rmb(sd):
	hub.remove_swatch(sd)

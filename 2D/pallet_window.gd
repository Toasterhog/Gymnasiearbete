extends Panel
@onready var hbc: HBoxContainer = $ScrollContainer/HBoxContainer


func add_swatch(c : Color):
	var s = Swatch.new()
	s.color = c
	hbc.add_child(s)
	hbc.move_child(s, 0)


func resize(b):
	if not b: #size.x > 240:
		size.x = 230
	else:
		size.x = 520

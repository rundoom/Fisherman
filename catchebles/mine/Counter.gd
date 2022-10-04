extends TextureRect


var original_size = rect_size.x
var ticks_left: int setget set_ticks


func set_ticks(value: int):
	rect_size.x = original_size * value

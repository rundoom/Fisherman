extends Line2D


onready var targetHook = $"%PoleHook"


func _process(_delta):
	points[1] = targetHook.global_position - global_position

tool
extends Path2D


export (Array, PackedScene) var fish_types


func _on_SpawnTimer_timeout():
	var fish_picked_type: PackedScene = fish_types[randi() % fish_types.size()]
	var fish = fish_picked_type.instance()
	$PathFollow2D.offset = randi()
	fish.global_position = $PathFollow2D.global_position
	get_tree().root.add_child(fish)


func _get_configuration_warning() -> String:
	if fish_types.empty():
		return "There is no fish types"
	else:
		return ""

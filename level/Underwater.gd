extends Area2D


func _on_Underwater_body_exited(body: Node) -> void:
	if body.has_method("on_depth_exiting"):
		body.on_depth_exiting()

extends Area2D


func _on_Bottom_body_entered(body: Node) -> void:
	body.queue_free()

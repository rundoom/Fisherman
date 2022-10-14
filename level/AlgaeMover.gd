extends RigidBody2D


func _ready() -> void:
	var temp_transform = global_transform
	call_deferred("set_as_toplevel", true)
	set_deferred("global_transform", temp_transform) 


func _on_Segment_reset() -> void:
	global_transform = $"../StaticBody2D".global_transform


func _on_Timer_timeout() -> void:
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled

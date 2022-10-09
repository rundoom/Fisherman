extends RigidBody2D


func on_depth_exiting():
	$AnimatedSprite.playing = true
	gravity_scale = 0
	linear_damp = rand_range(5, 15)
	

func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()


func set_size(size: Vector2):
	$CollisionShape2D.scale = size
	$AnimatedSprite.scale = size

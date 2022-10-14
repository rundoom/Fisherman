extends KinematicBody2D
class_name RealFish


export var velocity = Vector2(-1000, 0)

	

func get_hooked(hook_with: RemoteTransform2D) -> bool:
	var hooked_body: Node2D = get_node_or_null(hook_with.remote_path)
	if is_instance_valid(hooked_body): return false
	$BubbleEmitter.create_bubbles(15, 70, 0.1, 0.5)

	$CollisionShape2D.set_deferred("disabled", true)

	hook_with.remote_path = get_path()
	velocity = Vector2(0, 0)
	return true


func _physics_process(delta):
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)


func pass_away():
	create_particle_texture()
	queue_free()


func create_particle_texture():
	$RemainsParticles.emit_then_free()

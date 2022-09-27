extends KinematicBody2D


export var velocity = Vector2(-1000, 0)


func get_hooked(hook_with: RemoteTransform2D):
	if !get_node(hook_with.remote_path) is Fish:
		return
	
	$Particles2D.emitting = true
	
	$CollisionShape2D.set_deferred("disabled", true)
			
	hook_with.remote_path = get_path()
	velocity = Vector2(0, 0)


func _physics_process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision and collision.collider is StaticBody2D:
		queue_free()
		

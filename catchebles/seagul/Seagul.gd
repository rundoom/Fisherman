extends KinematicBody2D


export var velocity = Vector2(-1000, 0)
	

func get_hooked(hook_with: RemoteTransform2D):
	var hooked_body: Node2D = get_node(hook_with.remote_path)
	if !hooked_body is Fish: return
	
	$Particles2D.emitting = true
	
	$CollisionShape2D.set_deferred("disabled", true)
			
	hook_with.remote_path = get_path()
	
	if(hooked_body.has_method("pass_away")): hooked_body.pass_away()
	
	velocity = Vector2(0, 0)
	
	var temp_transform = $Egg.global_transform
	$Egg.set_as_toplevel(true)
	$Egg.global_transform = temp_transform
	
	$Egg.visible = true
	$Egg.set_deferred("mode", RigidBody2D.MODE_RIGID)


func _physics_process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision and collision.collider is StaticBody2D:
		queue_free()

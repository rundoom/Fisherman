extends KinematicBody2D


export var velocity:Vector2


func get_hooked(hook_with: RemoteTransform2D) -> bool:
	if !$Timer.is_stopped(): return false
	$Timer.start()
	var hooked_body: Node2D = get_node_or_null(hook_with.remote_path)
	var catched = get_node_or_null($Catcher.remote_path)
	if hooked_body is BigFish:
		hook_with.remote_path = ""
		hooked_body.get_caught($Catcher)
		return true
	elif !is_instance_valid(hooked_body) and is_instance_valid(catched):
		hook_with.remote_path = $Catcher.remote_path
		$Catcher.remote_path = ""
		return false
		
	return false


func _physics_process(delta):
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)


func start_action():
	velocity = Vector2(50, 0)

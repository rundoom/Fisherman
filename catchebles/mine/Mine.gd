extends KinematicBody2D


export (int, 0, 10, 1) var ticks = 3
export var velocity = Vector2(-500, 0)


func _ready() -> void:
	$Counter.ticks_left = ticks


func get_hooked(hook_with: RemoteTransform2D) -> bool:
	var hooked_body: Node2D = get_node_or_null(hook_with.remote_path)
	if is_instance_valid(hooked_body): return false

	$CollisionShape2D.set_deferred("disabled", true)

	hook_with.remote_path = get_path()
	$Timer.start()
	return true


func tick():
	if ticks == 0:
		get_tree().call_group("detonatable", "pass_away")
		get_tree().call_group("shakable", "apply_noise_shake", 120.0)
		$Explosion.explode()
		queue_free()
	ticks -= 1
	$Counter.ticks_left = ticks


func _physics_process(delta: float) -> void:
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)

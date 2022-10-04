extends KinematicBody2D


export (int, 0, 10, 1) var ticks = 3
export var velocity = Vector2(-500, 0)


func _ready() -> void:
	$Counter.ticks_left = ticks


func get_hooked(hook_with: RemoteTransform2D):
	var hooked_body: Node2D = get_node(hook_with.remote_path)
	if hooked_body != null: return

	$CollisionShape2D.set_deferred("disabled", true)

	hook_with.remote_path = get_path()
	$Timer.start()


func tick():
	if ticks == 0:
		get_tree().call_group("detonatable", "pass_away")
		get_tree().call_group("shakable", "apply_noise_shake", 120.0)
		queue_free()
	ticks -= 1
	$Counter.ticks_left = ticks


func _physics_process(delta: float) -> void:
	move_and_collide(velocity * delta)

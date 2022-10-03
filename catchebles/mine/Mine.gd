extends KinematicBody2D


func get_hooked(hook_with: RemoteTransform2D):
	var hooked_body: Node2D = get_node(hook_with.remote_path)
	if hooked_body != null: return
	
	$CollisionShape2D.set_deferred("disabled", true)

	hook_with.remote_path = get_path()
	$Timer.start()
	
	
func detonate():
	get_tree().call_group("detonatable", "pass_away")
	queue_free()


func _physics_process(delta: float) -> void:
	$Label.text = String(round($Timer.time_left))

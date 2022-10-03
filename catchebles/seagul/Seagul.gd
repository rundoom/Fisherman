extends KinematicBody2D
class_name Seagul


signal egg_released(x_pos)


export var velocity = Vector2(-1000, 0)
const Egg: PackedScene = preload("res://catchebles/seagul/Egg.tscn")


func get_hooked(hook_with: RemoteTransform2D):
	var hooked_body: Node2D = get_node(hook_with.remote_path)
	if !hooked_body is Fish: return
	
	$Particles2D.emitting = true
	
	$CollisionShape2D.set_deferred("disabled", true)
	velocity = Vector2(0, 0)

	hook_with.remote_path = get_path()
	
	if hooked_body.has_method("pass_away"): hooked_body.pass_away()
	
	release_egg()


func release_egg():
	var egg = Egg.instance()
	var temp_transform = global_transform
	remove_child(egg)
	
	if get_tree().get_nodes_in_group("eggs").size() == 0:
		get_tree().call_group("egg_hunters", "hunt_egg", temp_transform)
		
	get_tree().current_scene.add_child(egg)
	egg.global_transform = temp_transform


func _physics_process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)


func pass_away():
	$Particles2D.emit_then_free()
	queue_free()

extends Node2D


func hunt_egg(egg_trasform):
	global_position.x = egg_trasform.origin.x
	$AnimationPlayer.play("devour")


func get_hooked(hook_with: RemoteTransform2D):
	var hooked_body: Node2D = get_node(hook_with.remote_path)
	if !hooked_body is Seagul: return
	
	$AnimationPlayer.current_animation = "RESET"
	$AnimationPlayer.advance(0)
	$AnimationPlayer.stop()
	
	$BigFish.rotation_degrees = 90
	$BigFish.position = $Position2D.position.rotated(-deg2rad($BigFish.rotation_degrees))
	
	$BigFish/CollisionShape2D.set_deferred("disabled", true)

	hook_with.remote_path = get_path()
	
	if hooked_body.has_method("pass_away"): hooked_body.pass_away()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "devour": $AnimationPlayer.play("RESET")

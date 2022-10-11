extends Node2D
class_name BigFish


func hunt_egg(egg_trasform):
	global_position.x = egg_trasform.origin.x
	
	$AnimationPlayer.play("devour")
	$BigFish/CollisionShape2D.disabled = false
	
	get_tree().call_group("big_fish_hunters", "start_action")


func get_hooked(hook_with: RemoteTransform2D) -> bool:
	var hooked_body: Node2D = get_node_or_null(hook_with.remote_path)
	if !hooked_body is Seagul: return false
	$BigFish/BubbleEmitter.create_bubbles(30, 100, 0.3, 1.5)
	
	$AnimationPlayer.current_animation = "RESET"
	$AnimationPlayer.advance(0)
	$AnimationPlayer.stop()
	
	$BigFish.rotation_degrees = 90
	$BigFish.position = $HookPlace.position.rotated(deg2rad(-$BigFish.rotation_degrees))
	
	$BigFish/CollisionShape2D.set_deferred("disabled", true)

	hook_with.remote_path = get_path()
	
	if hooked_body.has_method("pass_away"): hooked_body.pass_away()
	return true
	

func get_caught(catcher: RemoteTransform2D):
	$AnimationPlayer.current_animation = "RESET"
	$AnimationPlayer.advance(0)
	$AnimationPlayer.stop()
	
	$BigFish.rotation_degrees = 90
	$BigFish.position = $CatchPlace.position.rotated(deg2rad(-$BigFish.rotation_degrees))
	
	$BigFish/CollisionShape2D.set_deferred("disabled", true)

	catcher.remote_path = get_path()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "devour": $AnimationPlayer.play("RESET")
	
	
func pass_away():
	$BigFish.create_particle_texture()
	queue_free()

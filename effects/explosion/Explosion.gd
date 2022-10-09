extends Node2D


func explode():
	var current_scene = get_tree().current_scene
	var final_position = global_position
	
	get_parent().remove_child(self)
	current_scene.add_child(self)
	
	global_position = final_position
	
	visible = true
	$Debris.emitting = true
	$Smoke.emitting = true
	$AnimatedSprite.playing = true
	
	yield(get_tree().create_timer(max($Debris.lifetime, $Smoke.lifetime)), "timeout")
	
	queue_free()

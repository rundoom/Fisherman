extends Particles2D
class_name RemainsParticles


func emit_then_free():
	emitting = false
	var current_scene = get_tree().current_scene
	var final_position = get_parent().global_position
	
	get_parent().remove_child(self)
	current_scene.add_child(self)
	
	global_position = final_position
	
	emitting = true
	yield(get_tree().create_timer(lifetime), "timeout")
	
	queue_free()

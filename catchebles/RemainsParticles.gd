extends Particles2D
class_name RemainsParticles


func emit_then_free():
	var root = get_tree().root
	var final_position = get_parent().global_position
	
	get_parent().remove_child(self)
	root.add_child(self)
	
	global_position = final_position
	
	emitting = true
	yield(get_tree().create_timer(lifetime), "timeout")
	
	queue_free()
	

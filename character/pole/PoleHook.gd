extends RigidBody2D


func _ready():
	yield(get_tree().get_root(), "ready")
	var temp_transform = global_transform
	set_as_toplevel(true)
	global_transform = temp_transform


func _integrate_forces(state):
	

func un

extends KinematicBody2D


signal hooked(hook_with)


func get_hooked(hook_with: RemoteTransform2D):
	emit_signal("hooked", hook_with)

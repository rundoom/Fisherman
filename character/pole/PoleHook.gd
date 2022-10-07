extends RigidBody2D


func _ready():
	yield(get_tree().current_scene, "ready")
	var temp_transform = global_transform
	set_as_toplevel(true)
	global_transform = temp_transform


func _physics_process(_delta):
	look_at(owner.global_position)


func _on_PoleHook_body_entered(body: Node2D):
	if body.has_method("get_hooked"):
		var is_hooked = body.get_hooked($RemoteTransform2D)
		
		# warning-ignore:return_value_discarded
		if is_hooked: body.connect("tree_exiting", self, "_remove_connection")
		
		get_tree().call_group("shakable", "apply_noise_shake")


func _remove_connection():
	$RemoteTransform2D.remote_path = ""

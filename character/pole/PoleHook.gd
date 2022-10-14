extends RigidBody2D


func _ready():
	var temp_transform = global_transform
	call_deferred("set_as_toplevel", true)
	set_deferred("global_transform", temp_transform) 


func _physics_process(_delta):
	look_at(owner.global_position)


func _on_PoleHook_body_entered(body: Node2D):
	if body.has_method("get_hooked"):
		var is_hooked = body.get_hooked($RemoteTransform2D)
		
		# warning-ignore:return_value_discarded
		if !body.is_connected("tree_exiting", self, "_remove_connection") and is_hooked:
			body.connect("tree_exiting", self, "_remove_connection", [body])
		
		get_tree().call_group("shakable", "apply_noise_shake")


func _remove_connection(from_body: Node):
	var current_remote = get_node_or_null($RemoteTransform2D.remote_path)
	if current_remote == from_body: $RemoteTransform2D.remote_path = ""

extends KinematicBody2D


export var velocity:Vector2

var is_weak: bool = false setget set_weak
func set_weak(flag: bool):
	is_weak = flag
	$Polygon2D.color = "ff0000"


func get_hooked(hook_with: RemoteTransform2D) -> bool:
	var hooked_body: Node2D = get_node_or_null(hook_with.remote_path)
	
	if hooked_body is RealFish \
	or hooked_body is Seagul:
		hook_with.remote_path = ""
		hooked_body.pass_away()
	elif hooked_body is Mine:
		set_weak(true)
		hooked_body.pass_away()
	elif hooked_body is BigFish and is_weak:
		hooked_body.pass_away()
		get_tree().call_group("kraken_feed", "set_visible", true)
		
	return false


func _physics_process(delta):
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)


func start_action():
	$CollisionShape2D.disabled = false
	velocity = Vector2(-25, 0)
	



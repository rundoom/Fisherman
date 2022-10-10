extends KinematicBody2D


onready var sprite = $AnimatedSprite
export var velocity:Vector2


func get_hooked(hook_with: RemoteTransform2D) -> bool:
	var hooked_body: Node2D = get_node_or_null(hook_with.remote_path)
	if hooked_body is BigFish:
		hook_with.remote_path = ""
		hooked_body.get_caught($Catcher)
		return true
	return false


func _physics_process(delta):
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)


func start_action():
	velocity = Vector2(50, 0)

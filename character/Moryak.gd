extends KinematicBody2D


signal hooked

export var speed = 400
var screen_size
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	_handle_input()
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * speed * delta)
	
	
func _handle_input():
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	velocity = velocity.normalized()


func _on_PoleSimple_hooked() -> void:
	emit_signal("hooked")

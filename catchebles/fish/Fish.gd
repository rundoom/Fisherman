extends KinematicBody2D
class_name Fish


onready var animation_names = $AnimatedSprite.frames.get_animation_names()
export var velocity = Vector2(-1000, 0)


func _ready():
	$AnimatedSprite.animation = animation_names[randi() % animation_names.size()]


func get_hooked(hook_with: RemoteTransform2D):
	if !hook_with.remote_path.is_empty(): return
	$Particles2D.emitting = true
	
	$CollisionShape2D.set_deferred("disabled", true)
			
	hook_with.remote_path = get_path()
	velocity = Vector2(0, 0)


func _physics_process(delta):
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision and collision.collider is StaticBody2D:
		queue_free()
		

func pass_away():
	queue_free()

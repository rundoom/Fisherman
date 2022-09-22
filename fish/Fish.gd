extends KinematicBody2D


onready var animation_names = $AnimatedSprite.frames.get_animation_names()


func _ready():
	$AnimatedSprite.animation = animation_names[randi() % animation_names.size()]


func get_hooked(hook_with: RemoteTransform2D):
	$Particles2D.emitting = true
	
	for child in get_children():
		if child is CollisionShape2D or child is CollisionShape2D:
			child.set_deferred("disabled", true)
			
	hook_with.remote_path = get_path()

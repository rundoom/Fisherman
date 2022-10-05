extends KinematicBody2D
class_name Fish


onready var sprite = $AnimatedSprite
onready var animation_names = sprite.frames.get_animation_names()
export var velocity = Vector2(-1000, 0)


func _ready():
	sprite.animation = animation_names[randi() % animation_names.size()]
	

func get_hooked(hook_with: RemoteTransform2D):
	if !get_node_or_null(hook_with.remote_path) == null: return
	$Bubbles.emitting = true

	$CollisionShape2D.set_deferred("disabled", true)

	hook_with.remote_path = get_path()
	velocity = Vector2(0, 0)


func _physics_process(delta):
	# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta)


func pass_away():
	create_particle_texture()
	queue_free()


func create_particle_texture():
	var frame_res = sprite.frames.get_frame(sprite.animation, sprite.frame).get_data()

	var itex = ImageTexture.new()
	itex.create_from_image(frame_res, Texture.FLAGS_DEFAULT & ~Texture.FLAG_FILTER)
	
	$RemainsParticles.texture = itex
	$RemainsParticles.emit_then_free()

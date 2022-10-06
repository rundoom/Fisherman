extends KinematicBody2D


signal hooked(hook_with)

onready var sprite = $AnimatedSprite
signal pass_away


func get_hooked(hook_with: RemoteTransform2D):
	emit_signal("hooked", hook_with)


func create_particle_texture():
	var frame_res = sprite.frames.get_frame(sprite.animation, sprite.frame).get_data()

	var itex = ImageTexture.new()
	itex.create_from_image(frame_res, Texture.FLAGS_DEFAULT & ~Texture.FLAG_FILTER)
	
	$RemainsParticles.texture = itex
	$RemainsParticles.emit_then_free()


func pass_away():
	emit_signal("pass_away")
	create_particle_texture()

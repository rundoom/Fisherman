extends RichTextLabel





func _ready() -> void:
	$Tween.interpolate_property(
		self, "visible_characters", null, text.length(), 3, Tween.TRANS_BOUNCE)
	$Tween.start()
	

func _physics_process(delta: float) -> void:
	pass

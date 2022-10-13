extends Node2D


func wobble(_body: Node):
	$Polygon2D/Skeleton2D/AnimationPlayer.play("Wobble")

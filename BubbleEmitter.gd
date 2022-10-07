extends Node2D


const Bubble: PackedScene = preload("res://Bubble.tscn")


func create_bubbles(count: int = 1, spread: float = 0, min_scale: float = 1.0, max_scale: float = 1.0):
	for i in count:
		var bubble_scale = rand_range(min_scale, max_scale)
		
		var bubble = Bubble.instance()
		bubble.set_size(Vector2(bubble_scale, bubble_scale))
		bubble.global_position = global_position
		bubble.position.x += rand_range(-spread, spread)
		bubble.position.y += rand_range(-spread, spread)
		
		get_tree().current_scene.call_deferred("add_child", bubble)
		yield(get_tree().create_timer(0.02), "timeout")

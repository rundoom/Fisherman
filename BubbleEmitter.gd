extends Node2D


const Bubble: PackedScene = preload("res://Bubble.tscn")


func create_bubbles(count: int = 1, spread: float = 0, min_scale: float = 1.0, max_scale: float = 1.0):
	for i in count:
		var bubble_position = global_position
		bubble_position.x += rand_range(-spread, spread)
		bubble_position.y += rand_range(-spread, spread)
		
		var is_colliding = get_world_2d().direct_space_state.intersect_point(
			bubble_position, 1, [], 8, false, true
		).size() > 0
		
		if !is_colliding: continue
		
		var bubble = Bubble.instance()
		var bubble_scale = rand_range(min_scale, max_scale)
		bubble.set_size(Vector2(bubble_scale, bubble_scale))
		bubble.global_position = bubble_position
		
		get_tree().current_scene.call_deferred("add_child", bubble)
		yield(get_tree().create_timer(0.02), "timeout")

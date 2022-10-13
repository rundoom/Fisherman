extends Node2D


export (Array, NodePath) var waves_sorting


func _ready() -> void:
	for node_path in waves_sorting:
		var node := get_node_or_null(node_path)
		var node_trans = node.global_transform
		node.get_parent().call_deferred("remove_child", node)
		node.set_deferred("global_transform", node_trans)
		
		$Surface/Waves.call_deferred("add_child", node)

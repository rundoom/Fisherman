extends RigidBody2D


# Expose connection
export (NodePath) var joining


# Join to exposed node
func _ready():
	var node_to_join = get_node_or_null(joining)
	if node_to_join != null: $PinJoint2D.node_b = node_to_join.get_path()

extends Area2D

export(NodePath) onready var door = get_node(door) as StaticBody2D

func _on_Collectible_body_entered(body):
	if body.name == "Player" :
		self.queue_free()
		door.queue_free()

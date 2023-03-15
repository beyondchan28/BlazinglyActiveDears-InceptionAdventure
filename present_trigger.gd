extends Area2D

func _on_PresentTrigger_body_entered(body):
	if body.name == "GrabObject" and body.picked == false:
#		body.set_sleeping(true)
		get_parent().get_node("Table/AnimatedSprite").set_playing(true)
		get_parent().get_node("Curtain/AnimationPlayer").play("open")
		
		body.get_node("GrabArea").set_monitoring(false)
		yield(get_parent().get_node("Curtain/AnimationPlayer"), "animation_finished")
#		start_firework()
		self.queue_free()

func start_firework():
	for firework in get_parent().get_node("Firework").get_children():
			firework.set_emitting(true)

extends Area2D

var show := false

func _on_MessageBoxTrigger_body_entered(body):
	$Control.set_visible(!show)
	$Control/AnimationPlayer.play("text_anim")


func _on_MessageBoxTrigger_body_exited(body):
	$Control.set_visible(show)
	$Control/AnimationPlayer.stop()

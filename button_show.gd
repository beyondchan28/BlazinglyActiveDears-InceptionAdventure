extends Area2D

var go_down := false

#need to change to assign the hidden ground for more dynamic
export(NodePath) onready var hiddenGroundAnim = get_node(str(hiddenGroundAnim,"/AnimationPlayer"))

func _process(delta):
	if go_down:
		self.position.y += 1
	else:
		return

func _on_ButtonShowArea_area_entered(area):
	if area.name == "FootArea":
		go_down = true
		hiddenGroundAnim.play("showed")

func _on_ButtonShowArea_body_entered(body):
	if body.name == "Ground" or body.name == "Platform" or body.name == "HiddenGround" :
		set_deferred("monitoring", false)
		go_down = false

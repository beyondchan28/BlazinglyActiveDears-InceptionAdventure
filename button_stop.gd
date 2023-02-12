extends Area2D

var go_down := false
var ori_pos := Vector2.ZERO

#onready var movingPlatform = get_parent().get_node("ObstaclePath2D/PathFollow2D")
export(NodePath) onready var movingPlatform = get_node(movingPlatform) as PathFollow2D


func _process(delta):
	if go_down :
		self.position.y += 1
	else:
		moving_back()
#	print(is_monitoring())
#	print(is_connected("area_entered", self, "_on_ButtonStopArea_area_entered"))

func _on_ButtonStopArea_area_entered(area):
	if area.name == "FootArea":
#		for i in range(8):
#			print(i)
		movingPlatform.can_move = !movingPlatform.can_move
		go_down = true


func _on_ButtonStopArea_body_entered(body):
	if body.name == "Ground" or body.name == "Platform" or body.name == "HiddenGround":
		go_down = false
		set_deferred("monitoring", false)

func moving_back():
	if self.global_position <= ori_pos:
		if not is_connected("area_entered", self, "_on_ButtonStopArea_area_entered"):
			connect("area_entered", self,"_on_ButtonStopArea_area_entered")
		else:
			set_deferred("monitoring", true)
			
	else:
		self.position.y -= 1

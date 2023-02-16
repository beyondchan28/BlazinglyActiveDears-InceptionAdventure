extends Area2D

var go_down := false
var ori_pos := Vector2.ZERO

#need to change to assign the hidden ground for more dynamic
export(NodePath) onready var hiddenGroundAnim = get_node(str(hiddenGroundAnim,"/AnimationPlayer"))
#
#func _process(delta):
#	if go_down:
#		self.position.y += 1
#	else:
#		return
#
#func _on_ButtonShowArea_area_entered(area):
#	if area.name == "FootArea":
#		go_down = true
#		hiddenGroundAnim.play("showed")
#
#func _on_ButtonShowArea_body_entered(body):
#	if body.name == "Ground" or body.name == "Platform" or body.name == "HiddenGround" :
#		set_deferred("monitoring", false)
#		go_down = false

func _ready():
	hiddenGroundAnim.connect("animation_finished",self,"anim_finished",[], 4)
	ori_pos = self.global_position

func _physics_process(delta):
	if go_down :
		self.position.y += 0.15
		
	else:
		moving_back()
		print(self.global_position.length() - ori_pos.length())
		
#	print(is_monitoring())
#	print(is_connected("area_entered", self, "_on_ButtonStopArea_area_entered"))

func _on_ButtonShowArea_area_entered(area):
	if area.name == "FootArea":
		go_down = true
#		print("ori pos ", ori_pos.length())


func _on_ButtonShowArea_body_entered(body):
	if body.name == "Ground" or body.name == "Platform" or body.name == "HiddenGround":
		#the animation not waiting the current animation to finish
		if hiddenGroundAnim.get_assigned_animation() == "showed":
			play_anim("hide")
		else:
			play_anim("showed")
		hiddenGroundAnim.emit_signal("animation_finished", hiddenGroundAnim.get_current_animation())
		print(hiddenGroundAnim.get_assigned_animation())
		go_down = false
		set_deferred("monitoring", false)

func moving_back():
	if self.global_position.length() - ori_pos.length() == 0:
		if not is_connected("area_entered", self, "_on_ButtonShowArea_area_entered"):
			pass
		else:
			set_deferred("monitoring", true)
	else:
		self.position.y -= 0.15

func anim_finished(anim_name):
	connect("area_entered", self,"_on_ButtonShowArea_area_entered")
#	hiddenGroundAnim.connect("animation_finished",self,"anim_finished",[],4)

func play_anim(anim_name: String):
	if anim_name == hiddenGroundAnim.get_current_animation():
		pass
	else:
		hiddenGroundAnim.play(anim_name)

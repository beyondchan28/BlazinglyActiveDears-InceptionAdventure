extends Node2D


onready var door = $Door
var last_anim = []
var buttons_names = ["ShowButton", "ShowButton2", "ShowButton3", "ShowButton4", "ShowButton5", "ShowButton6"]

var amount: int
# Called when the node enters the scene tree for the first time.
func _ready():
	last_anim.resize(6)
	for child in get_children():
		if child.is_in_group("Button"):
#			child.get_node("StopButtonArea").connect("body_entered", self, "count", [child.get_name()])
			child.hiddenGroundAnim.connect("animation_finished", self, "count", [child.get_name()])


func _process(delta):
	if !self.has_node("Door"):
		cut_all()
	elif self.has_node("Door"):
		check_last_anim()
#	print(last_anim)
#func count(body, button_name):
#	var button
#	var get_anim
#	if body.name == "Player":
#		if door.is_inside_tree() and amount == 0:
#			door.queue_free()
#		button = self.get_node(button_name)
#		get_anim = button.hiddenGroundAnim.get_current_animation()
#		if get_anim == "hide":
#			amount -= 1
#		elif get_anim == "showed":
#			amount += 1

func count(finish_anim_name, button_name):
	if buttons_names.has(button_name):
		if finish_anim_name == "hide":
			amount -= 1
		elif finish_anim_name == "showed":
			amount += 1
		if self.has_node("Door"):
			var get_anim = self.get_node(button_name).hiddenGroundAnim.get_assigned_animation()
			var id = self.get_node(button_name).get_position_in_parent()
			last_anim.remove(id)
			last_anim.insert(id, get_anim)
	else:
		for name in buttons_names:
			var button = self.get_node(name).hiddenGroundAnim.play("showed")

func cut_all():
	for names in buttons_names:
		var button = self.get_node(names).hiddenGroundAnim
		if button.is_connected("animation_finished", self, "count"):
			button.disconnect("animation_finished", self, "count")
#			self.get_node(names).set_physics_process_internal(false)
			self.get_node(names).get_node("CollisionShape2D").set_disabled(true)
		else:
			return
			

func check_last_anim():
	for names in buttons_names:
		if not last_anim.has("showed") and not last_anim.has(null):
			door.queue_free()
	

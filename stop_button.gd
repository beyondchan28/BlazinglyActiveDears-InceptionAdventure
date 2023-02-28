extends KinematicBody2D

export(NodePath) onready var movingPlatform = get_node(movingPlatform).get_node("AnimationPlayer")

const DOWN = Vector2.DOWN
const UP = Vector2.UP
const STOP = Vector2.ZERO

export var pressed_speed = 0.4
var velocity = Vector2.ZERO

var ori_pos

var curr_button_state = BUTTON_STATE.NOT_PRESSED

enum BUTTON_STATE {PRESSED, NOT_PRESSED, PRESSED_COMPLETE}

func _ready():
	ori_pos = self.position

func _physics_process(delta):
	var length = ori_pos.abs().length() - position.abs().length()
	if abs(length) <= 1.0 and curr_button_state != BUTTON_STATE.PRESSED:
#		print(curr_button_state)
		curr_button_state = BUTTON_STATE.NOT_PRESSED
	
	match curr_button_state:
		BUTTON_STATE.PRESSED:
			velocity = DOWN * pressed_speed
		BUTTON_STATE.NOT_PRESSED:
			velocity = STOP
		BUTTON_STATE.PRESSED_COMPLETE:
			velocity = UP * pressed_speed
	
		
	self.global_position += velocity
#	self.set_constant_linear_velocity(Vector2(0,self.global_position.y))
#	print(velocity)
#	print(curr_button_state)
#	print(abs(ori_pos.length() - position.length()))

func _activate_platfrom():
	if movingPlatform.is_playing():
		movingPlatform.stop(false)
		
	else:
		movingPlatform.play()
	

#func _hidden(visible: bool):
#	$CollisionShape2D.set_deferred("disabled", visible)
#	self.set_visible(!visible)
#	print(is_visible())
#	print($CollisionShape2D.is_disabled())
	
	
func _on_StopButtonArea_body_entered(body):
	if body.is_in_group("ground"):
		curr_button_state = BUTTON_STATE.PRESSED_COMPLETE
		_activate_platfrom()
		

#func _on_StopButton_tree_entered():
#	for ground in get_tree().get_nodes_in_group("ground"):
#		if ground.name == "HiddenGround":
#			if ground.has_node(self.name):
#				_hidden(true)
#			else:
#				return

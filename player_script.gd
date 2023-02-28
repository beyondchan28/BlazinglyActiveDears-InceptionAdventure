extends KinematicBody2D

const UP = Vector2.UP
const DOWN = Vector2.DOWN
const MAX_SPEED = 50
const GRAVITY = 7.5
const ACCELERATION = 12.5
const JUMP_HEIGHT = -125

var motion = Vector2.ZERO

var knockBackStrength := 200.0

onready var anim = $AnimationPlayer
onready var graphic = $Sprite
onready var tween = $Tween

var canPick = true

signal dead

func _physics_process(delta):
	motion.y += GRAVITY
	var fraction = false
	
	if Input.is_action_pressed("right"):
		graphic.set_flip_h(false)
		play_anim("run")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
	elif Input.is_action_pressed("left"):
		graphic.set_flip_h(true)
		play_anim("run")
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		
	else:
		play_anim("idle")
		fraction = true
	
	if self.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_HEIGHT
		if fraction == true :
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		play_anim("jump")
		
		if fraction == true :
			motion.x = lerp(motion.x, 0, 0.05)
		
	motion = self.move_and_slide_with_snap(motion,DOWN, UP, true)


func play_anim(anim_name: String):
	if anim_name == anim.get_current_animation():
		pass
	else:
		anim.play(anim_name)

func receive_knockback(knockBackSourcePos: Vector2):
	var knockBackDirection = knockBackSourcePos.direction_to(self.global_position)
	var knockBack = (knockBackDirection * knockBackStrength)
	
	knockBack.y = 0
	motion.x += knockBack.x
	
#	tween.interpolate_property(self, "global_position",
#	self.global_position, knockBack, 0.2,
#	Tween.TRANS_ELASTIC, Tween.EASE_OUT)
#
#	print("knockback: ", knockBack)
#	print("self: ", self.global_position)
#	tween.start()
	

func _on_HitBox_body_entered(body):
	if body.name == "Enemy" :
		receive_knockback(body.global_position)

func _on_FootArea_body_entered(body):
	if body.is_in_group("Button") and self.is_on_floor():
		body.curr_button_state = body.BUTTON_STATE.PRESSED

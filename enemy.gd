extends KinematicBody2D

var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
const SPEED = 25

onready var ledgeRight := $LedgeCheckRight
onready var ledgeLeft := $LedgeCheckLeft


func _physics_process(delta):
	var found_wall = is_on_wall()
	var found_ledge = not ledgeLeft.is_colliding() or not ledgeRight.is_colliding()
	
	if found_wall or found_ledge :
		direction *= -1
	
	velocity = direction * SPEED
	move_and_slide(velocity, Vector2.UP)

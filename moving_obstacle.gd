extends PathFollow2D

export var speed = 2
var can_move = true
#func _ready():
#	$Ground.set_constant_linear_velocity(Vector2(speed, 0))

func _process(delta):

#	print($Ground.get_constant_linear_velocity())
	if can_move:
		set_offset(get_offset() + speed * delta)
	

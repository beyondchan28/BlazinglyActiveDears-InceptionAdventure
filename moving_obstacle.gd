extends PathFollow2D

export var speed = 2
var can_move = true
func _process(delta):
	if can_move:
		set_offset(get_offset() + speed * delta)
	

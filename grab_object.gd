extends RigidBody2D


var picked = false

func _physics_process(delta):
	if picked == true:
		self.position = get_parent().get_node("Player/Position2D").global_position

func _input(event):
	if Input.is_action_just_pressed("grab"):
		if picked == true:
			picked = false
			get_parent().get_node("Player").canPick = true
			if get_parent().get_node("Player").graphic.flip_h == false:
				apply_impulse(Vector2.ZERO, Vector2(20, -5))
			else:
				apply_impulse(Vector2.ZERO, Vector2(-20, -5))
		else:
			var bodies = $GrabArea.get_overlapping_bodies()
			for body in bodies:
				if body.name == "Player" and body.canPick == true:
					picked = true
					body.canPick = false
			

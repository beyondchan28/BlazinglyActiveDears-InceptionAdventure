extends Node2D

signal start

onready var spawn_pos_x

var firework = preload("res://firework.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_pos_x = rand_range(15.0, 205.0)

func shoot():
#	print("lol")
	var inst_firework = firework.instance()
	self.add_child(inst_firework)
	inst_firework.set_global_position(Vector2(spawn_pos_x, self.global_position.y))
	inst_firework.emit = true
		



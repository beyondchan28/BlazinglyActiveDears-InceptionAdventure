extends MeshInstance2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var emit = false
var curr_node_name : String

var explosions = [
	preload("res://Firework1.tscn"),
	preload("res://Firework2.tscn"),
	preload("res://Firework3.tscn"),
	preload("res://Firework4.tscn"),
	preload("res://Firework5.tscn"),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var explode_point_y = rand_range(20.0, 40.0)
	if self.get_child_count() == 0:
		self.global_position.y -= 1 
	
	if emit and self.global_position.y <= explode_point_y:
		var explode = random_explosion()
		curr_node_name = explode.name
		self.self_modulate = Color(0.0, 0.0, 0.0, 0.0)
		self.add_child(explode)
		emit = false
	if self.has_node(curr_node_name):
		if self.get_node(curr_node_name).is_emitting() == false:
			self.queue_free()
	
func random_explosion():
	var rand_explosion = randi() % len(explosions)
	var inst = explosions[rand_explosion].instance()
	inst.set_one_shot(true)
	inst.set_emitting(true)
	
	return inst

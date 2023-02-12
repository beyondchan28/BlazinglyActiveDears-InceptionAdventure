extends Area2D

onready var player = get_parent().get_node("Player")

export(Array, NodePath) onready var all_cam_path
export(Array, NodePath) onready var all_restart_point_path

var all_cam = []
var all_restart_point = []

var count_cam := 1
var swap_cam := false
var current_index_cam := 0

func _ready():
	for cam_path in all_cam_path:
		all_cam.append(get_node(cam_path)) #getting every cam node
	for restart_point_path in all_restart_point_path:
		all_restart_point.append(get_node(restart_point_path)) #getting every restart point node

func _process(delta):
	current_index_cam = check_current_cam(all_cam)

func _input(event):
	if Input.is_action_just_pressed("restart"):
		respawn()

func _on_SwitchCamArea_body_entered(body):
	if body.name == "Player" :
		swap_cam = true

func check_current_cam(all_cam: Array):
	for ind in all_cam.size():
		if all_cam[ind].is_current() == true:
			if swap_cam:
				count_cam += ind
				if count_cam % 2 == 0:
					switch_cam(all_cam[ind], all_cam[ind-1])
				else:
					switch_cam(all_cam[ind], all_cam[ind+1])
			return ind

func switch_cam(cam1: Camera2D, cam2: Camera2D):
	cam1._set_current(false)
	cam2._set_current(true)
	
	count_cam = 1
	swap_cam = false

func respawn():
	player.global_position = all_restart_point[current_index_cam].global_position

extends CanvasLayer


func _ready():
	get_tree().paused = true



func _on_Button_pressed():
	get_tree().paused = false
	self.queue_free()

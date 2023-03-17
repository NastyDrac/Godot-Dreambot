extends AudioStreamPlayer


var toPlay
func _ready():
	stream = toPlay
	play()


func _on_AudioStreamPlayer2D_finished():
	queue_free()

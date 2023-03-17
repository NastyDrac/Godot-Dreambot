extends AudioStreamPlayer


var toPlay = preload("res://Monster_Roar_4.wav")
func _ready():
	stream = toPlay
	play()


func _on_AudioStreamPlayer2D_finished():
	print("played")
	queue_free()

extends Node2D

var searchDistance : float 

var player

var pausePoint = 0
var found = false
var searchPattern = "search"

onready var monsterGaze = $Node2D
onready var animate = $AnimationPlayer
onready var tween = $Tween
onready var audio = preload("res://gameobjects/AudioStreamPlayer.tscn")
var sound = preload("res://Monster_Roar_4.wav")

func _ready():
	
	Global.monster = self
	animate.play(searchPattern)


func locatePlayer():
	pausePoint = animate.get_current_animation_position()
	animate.stop(false)
	monsterGaze.look_at(player.global_position)
	animate.play("zoomIn")
	
	
func _process(delta):
	searchDistance = rand_range(300, 1000)
	
	
	if found == true:
		locatePlayer()
	else:
		
		animate.play("search")
		
		
		
	
	if player != null and player.get_parent().hidden <= 0:
		found = false
	
	if player != null:
		tween.interpolate_property(self, "global_position", global_position, Vector2(player.global_position.x, player.global_position.y - searchDistance) , 5)
		tween.start()



func _on_monsterGaze_body_entered(body):
	if body.get_name() == "Player":
		player = body
		if player.get_parent().hidden > 0:
			var newAudio = audio.instance()
			add_child(newAudio)
			found = true
		


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "zoomIn":
		if found == true:
			Global.die()

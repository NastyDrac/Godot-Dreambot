extends Node

onready var player = preload("res://Player/Player.tscn")
var spawnPoint = Vector2()
var oldPlayer
var selectLayer
var monster

func die():
	monster.player = null
	monster.found = false
	oldPlayer.queue_free()
	var newPlayer = player.instance()
	selectLayer.add_child(newPlayer)
	newPlayer.position = spawnPoint

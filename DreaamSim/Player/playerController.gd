extends Node2D

export var coyoteTime = 15
export var jumpTimer = 15
export var speed = 10
export var jumpHeight = 50
export var wallGravity = 10
export var sprintSpeed = 500
export var sprintTimer =15

var spawnPoint = Vector2()
var sprintBuffer = 0
var originalSpeed : float
var hidden = 4
var coyoteBuffer = 0
var jumpBuffer = 0
var velocity = Vector2()
var gravity = 30
var numJumps = 1

onready var playerBody = $Player
onready var sprite = $Player/AnimatedSprite

func _ready():
	originalSpeed = speed
	Global.oldPlayer = self
	print(get_parent())

func _physics_process(delta):
	movement()
	
func movement():
	
	velocity.x = (Input.get_action_raw_strength("Right") * speed) - (Input.get_action_raw_strength("Left") * speed)
	if Input.is_action_pressed("Sprint"):
		speed = sprintSpeed
	else:
		speed = originalSpeed
	
	if playerBody.is_on_floor() or playerBody.is_on_wall():
		coyoteBuffer = coyoteTime
		numJumps = 1
	if playerBody.is_on_floor() == false:
		velocity.y += gravity
		coyoteBuffer -= 1
		
	if playerBody.is_on_ceiling() == true:
		velocity.y = 0
		velocity.y += 1
	
	if Input.is_action_just_pressed("Jump"):
		jumpBuffer = jumpTimer
		
		
		
	if jumpBuffer > 0:
		jumpBuffer -= 1

	if jumpBuffer > 0 and coyoteBuffer > 0:
		velocity.y = -jumpHeight 
		jumpBuffer = 0
		coyoteBuffer = 0
		
	elif Input.is_action_just_pressed("Jump") and numJumps > 0:
		velocity.y = -jumpHeight
		numJumps -= 1
		
		
		
	if Input.is_action_just_released("Jump"):
		velocity.y += 100
		
	if Input.is_action_just_pressed("Down"):
		playerBody.set_collision_layer_bit(0, false)
	if Input.is_action_just_released("Down"):
		playerBody.set_collision_layer_bit(0, true)
		
	if playerBody.is_on_wall() == true:
		gravity = wallGravity
	else:
		gravity = 30
	
	playerBody.move_and_slide(velocity, Vector2.UP, false)
	lerp(playerBody.position, velocity, 0.2)
	




func _on_Player_area_entered(area):
	if area.is_in_group("hideSpot"):
		hidden -= 1
	if area.is_in_group("Hazard"):
		Global.die()


func _on_Player_area_exited(area):
	if area.is_in_group("hideSpot"):
		hidden += 1
	if hidden == 0:
		Global.spawnPoint = playerBody.global_position



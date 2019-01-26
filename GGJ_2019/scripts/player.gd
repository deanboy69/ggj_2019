extends KinematicBody2D
var speed = 5
var pos = Vector2()
var is_punching = false
var is_kicking = false

func _ready():
	#var pos = get_global_position()
	pass
	
	
func _physics_process(delta):
	pos = get_global_position()
	if global.shift_level == false:
		player_input()
	#set_global_position(pos)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func player_input():
	if Input.is_action_pressed("ui_up"):
		position += Vector2(0,-speed)
	if Input.is_action_pressed("ui_down"):
		position += Vector2(0,speed)
	if Input.is_action_pressed("ui_left"):
		position += Vector2(-speed,0)
	if Input.is_action_pressed("ui_right"):
		position += Vector2(speed,0)
	if Input.is_action_pressed("punch"):
		is_punching = true
	if Input.is_action_pressed("kick"):
		is_kicking = true
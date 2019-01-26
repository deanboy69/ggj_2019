extends KinematicBody2D

var pos = Vector2()

func _ready():
	#var pos = get_global_position()
	pass
	
	
func _physics_process(delta):
	pos = get_global_position()
	player_input()
	set_global_position(pos)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func player_input():
	if Input.is_action_pressed("ui_up"):
		pos += Vector2(0,-10)
	if Input.is_action_pressed("ui_down"):
		pos += Vector2(0,10)
	if Input.is_action_pressed("ui_left"):
		pos += Vector2(-10,0)
	if Input.is_action_pressed("ui_right"):
		pos += Vector2(10,0)
		
extends Area2D

onready var sprite = get_node('sprite')
onready var body = get_node('body')
onready var punch_rect = get_node('punch_rect')
onready var kick_rect = get_node('kick_rect')

onready var unit

var move_timer 

var colliding = false
var collision_list = []


var speed = 500
var pos = Vector2()
var vel = Vector2()
var is_punching = false
var is_kicking = false
var is_moving = false

func _ready():
	var unit = stats.player_stats
	sprite.set_texture(unit.skin)
	
	
	move_timer = Timer.new()
	move_timer.connect("timeout",self,"anim")
	add_child(move_timer)
	move_timer.wait_time = 0.2
	move_timer.start()
	

	
	
	
	
func _physics_process(delta):
	#pos = get_global_position()
	take_damage()
	if global.shift_level == false:
		player_input()
		
	
	
	if vel.x > 0:
		scale.x = 1
	if vel.x < 0:
		scale.x = -1
		
	if colliding == false:
		position += vel * delta


func take_damage():
	pass
	
	

func player_input():
	if is_punching == false:
		if is_kicking == false:
			if Input.is_action_pressed("ui_up"):
				is_moving = true
				vel = Vector2(0,-speed)
				#position += vel * delta
			if Input.is_action_pressed("ui_down"):
				is_moving = true
				vel = Vector2(0,speed)
				#position += vel
			if Input.is_action_pressed("ui_left"):
				is_moving = true
				vel = Vector2(-speed,0)
				#position += vel
			if Input.is_action_pressed("ui_right"):
				is_moving = true
				vel = Vector2(speed,0)
				#position += vel

	
	if Input.is_action_just_released("ui_up"):
		is_moving = false
		sprite.frame = 0
		vel = Vector2(0,0)
	if Input.is_action_just_released("ui_down"):
		is_moving = false
		sprite.frame = 0
		vel = Vector2(0,0)
	if Input.is_action_just_released("ui_left"):
		is_moving = false
		sprite.frame = 0
		vel = Vector2(0,0)
	if Input.is_action_just_released("ui_right"):
		is_moving = false
		sprite.frame = 0
		vel = Vector2(0,0)
		
	if Input.is_action_pressed("punch"):
		if is_kicking == false:
			is_punching = true
			sprite.frame = 3
	if Input.is_action_pressed("kick"):
		if is_punching == false:
			is_kicking = true
			sprite.frame = 4
			
			
	if Input.is_action_just_released("punch"):
		if is_punching == true:

			sprite.frame = 0
			is_punching = false
	if Input.is_action_just_released("kick"):
		if is_kicking == true:

			sprite.frame = 0
			is_kicking = false
		
func anim():
	if is_punching == false:
		if is_kicking == false:	
			if is_moving == true:
				if sprite.frame < 2:
					sprite.frame = sprite.frame + 1
				else:
					sprite.frame = 0


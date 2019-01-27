extends Area2D

onready var sprite = get_node('sprite')
onready var body = get_node('body')
onready var punch_rect = get_node('punch_rect')
onready var kick_rect = get_node('kick_rect')

onready var U = get_node('U')
onready var D = get_node('D')
onready var L = get_node('L')
onready var R = get_node('R')
onready var UL = get_node('UL')
onready var UR = get_node('UR')
onready var DL = get_node('DL')
onready var DR = get_node('DR')

onready var p_u = get_node('U/p_U')
onready var p_d = get_node('D/p_D')
onready var p_l = get_node('L/p_L')
onready var p_r = get_node('R/p_R')



onready var unit

var move_timer 

var colliding = false
var collision_list = []

var barrier
var dist_x
var dist_y
var blocked_up = false
var blocked_down = false
var blocked_left = false
var blocked_right = false
var moving_up = false
var moving_down = false
var moving_left = false
var moving_right = false

var speed = 300
var pos = Vector2()
var vel = Vector2()
var is_punching = false
var is_kicking = false
var is_moving = false

var in_punching_range
var in_kicking_range
var target


onready var health
onready var health_timer
var hit

func _ready():
	var unit = stats.player_stats
	sprite.set_texture(unit.skin)
	health = unit.health
	self.add_to_group('players')
	
	move_timer = Timer.new()
	move_timer.connect("timeout",self,"anim")
	add_child(move_timer)
	move_timer.wait_time = 0.2
	move_timer.start()
	
	#pos_array = [U,D,L,R,UL,UR,DL,DR]
	
	health_timer = Timer.new()
	add_child(health_timer)
	health_timer.one_shot = true
	health_timer.wait_time = 1.5
	
	
func _physics_process(delta):
	#pos = get_global_position()
	#print(p_u.get_global_position())
	#take_damage()
	if global.shift_level == false:
		speed = 300
		player_input()
		print("input time!")
	elif global.shift_level == true:
		sprite.frame = 0
		speed = -300
		

	if vel.x > 0:
		scale.x = 1
	if vel.x < 0:
		scale.x = -1
		
	if vel.y > 0:
		if blocked_down == true:
			vel.y = 0
	if vel.y < 0:
		if blocked_up == true:
			vel.y = 0
	if vel.x > 0:
		if blocked_right == true:
			vel.x = 0
	if vel.x < 0:
		if blocked_left == true:
			vel.x = 0
	
	position += vel * delta
		
		

func take_damage(enemy):
	if hit == true:
		if health_timer.time_left == 0:
			health_timer.start()
			health -= 1 * enemy.damage_boost
			#print('player_invincible')
			print(health)
	
	
	

func player_input():
	if is_punching == false:
		if is_kicking == false:
			if Input.is_action_pressed("ui_up"):
				if blocked_up == false:
					is_moving = true
					moving_up = true
					vel = Vector2(0,-speed)
			if Input.is_action_pressed("ui_down"):
				if blocked_down == false:
					is_moving = true
					moving_down = true
					vel = Vector2(0,speed)
			if Input.is_action_pressed("ui_left"):
				if scale.x == 1:
					if vel.x == 0:
						scale.x = -1
					if blocked_left == false:
						is_moving = true
						moving_left = true
						vel = Vector2(-speed,0)
				if scale.x == -1:
					if blocked_right == false:
						is_moving = true
						moving_left = true
						vel = Vector2(-speed,0)
			if Input.is_action_pressed("ui_right"):
				if scale.x == 1:
					if blocked_right == false:
						is_moving = true
						moving_right = true
						vel = Vector2(speed,0)
				if scale.x == -1:
					if vel.x == 0:
						scale.x = 1
					if blocked_left == false:
						is_moving = true
						moving_right = true
						vel = Vector2(speed,0)


	
	if Input.is_action_just_released("ui_up"):
		is_moving = false
		moving_up = false
		sprite.frame = 0
		vel = Vector2(0,0)
	if Input.is_action_just_released("ui_down"):
		is_moving = false
		moving_down = false
		sprite.frame = 0
		vel = Vector2(0,0)
	if Input.is_action_just_released("ui_left"):
		is_moving = false
		moving_left = false
		sprite.frame = 0
		vel = Vector2(0,0)
	if Input.is_action_just_released("ui_right"):
		is_moving = false
		moving_right = false
		sprite.frame = 0
		vel = Vector2(0,0)
		
	if Input.is_action_just_pressed("punch"):
		if is_kicking == false:
			is_punching = true
			sprite.frame = 3
			if in_punching_range == true:
				target.taking_damage()
				#target.health -= 1
				print(target.health)
	if Input.is_action_just_pressed("kick"):
		if is_punching == false:
			is_kicking = true
			#sprite.frame = 4
			
			
	if Input.is_action_just_released("punch"):
		if is_punching == true:
			sprite.frame = 0
			is_punching = false
	if Input.is_action_just_released("kick"):
		if is_kicking == true:

			#sprite.frame = 0
			is_kicking = false
		
func anim():
	if global.shift_level == false:
		if is_punching == false:
			if is_kicking == false:	
				if is_moving == true:
					if sprite.frame < 2:
						sprite.frame = sprite.frame + 1
					else:
						sprite.frame = 0


func _on_player_area_entered(area):
	pass
	

func _on_U_area_entered(area):
	if area.is_in_group('enemies'):
		blocked_up = true

func _on_U_area_exited(area):
	if area.is_in_group('enemies'):
		blocked_up = false


func _on_R_area_entered(area):
	if area.is_in_group('enemies'):
		blocked_right = true

func _on_R_area_exited(area):
	if area.is_in_group('enemies'):
		blocked_right = false

func _on_D_area_entered(area):
	if area.is_in_group('enemies'):
		blocked_down = true

func _on_D_area_exited(area):
	if area.is_in_group('enemies'):
		blocked_down = false

func _on_L_area_entered(area):
	if area.is_in_group('enemies'):
		blocked_left = true

func _on_L_area_exited(area):
	if area.is_in_group('enemies'):
		blocked_left = false

func _on_punch_rect_area_entered(area):
	#print(area)
	if area.is_in_group('enemies'):
		target = area
		in_punching_range = true
		
func _on_punch_rect_area_exited(area):
	if area.is_in_group('enemies'):
		target = null
		in_punching_range = false

func _on_hit_rect_area_entered(area):
	hit = true

func _on_hit_rect_area_exited(area):
	hit = false




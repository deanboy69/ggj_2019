extends Area2D


var timer
var speed = 100
var vel = Vector2()

#STATES
var chasing = false
var avoiding = false
var sliding = false
var focus		#	<--this variable allows player target to be preserved but changes immediate 'focus' to change depending on state
var focus_pos
var target
var target_pos = Vector2()
var direction
var dist

var avoid_timer
var avoid_ending = false

#ATTACK VARIABLES
var punchable = false
var punch_timer

var damage_timer
var damage_boost


var colliding = false
var colliding_body



onready var sprite = get_node("sprite")
onready var unit
onready var health

func _ready():
	unit = stats.hobo1_stats
	sprite.set_texture(unit.skin)
	sprite.set_frame(0)
	self.add_to_group(unit.group)
	health = unit.health
	
	timer = Timer.new()
	timer.connect("timeout",self,"anim")
	add_child(timer)
	timer.wait_time = 0.2
	timer.start()
	
	
	punch_timer = Timer.new()
	punch_timer.connect("timeout",self,"punch")
	add_child(punch_timer)
	#punch_timer.one_shot = true
	punch_timer.wait_time = .5
	punch_timer.start()
	
	avoid_timer = Timer.new()
	avoid_timer.one_shot = true
	add_child(avoid_timer)
	avoid_timer.wait_time = 1
	#avoid_timer.start()
	
	damage_timer = Timer.new()
	damage_timer.one_shot = true
	add_child(damage_timer)
	damage_timer.wait_time = 1.5
	
	

func _physics_process(delta):
	#print(punchable)
	#print(avoid_timer.time_left)
	movement()
	position += vel * delta
	#check state, if state is seek: go to target the player. if obstructed, find obstruction type.
	#if type object, try moving. if type enemy, stop, do calc for timeout on move.
	#print(colliders)
	
	
	if target != null:
		if sprite.frame == 3:
			#print('true')
			target.take_damage(self)
	
	if vel.x > 0:
		scale.x = 1
	if vel.x < 0:
		scale.x = -1
	
	if vel.x == 0:
		#if punchable == false:
			#sprite.frame = 0
		
		if target_pos.x > position.x:
			scale.x = 1
		else:
			scale.x = -1
			
	if chasing == true:
		focus = target
	
	if unit == stats.boss1_stats:
		damage_boost = 3
	else:
		damage_boost = 1
		
	if avoid_ending == true:
		if avoid_timer.time_left == 0:
			avoid_ending = false
			chasing = true
			avoiding = false
		
	if health == 0:
		sprite.hide()
		target = null
		position = Vector2(0,1500)
	

func taking_damage():
	#damage_timer.start()
	print('invincible')
	sprite.frame = 0
	health -= 1

func movement():
	if focus != null:
		if focus == target:
			if avoiding == false:
				target_pos = target.position
				dist = target_pos.distance_to(position)
				vel = (target_pos - position).normalized() * speed
				if dist <= 60:
					if abs(target_pos.y - position.y) < 20:
						vel = Vector2(0,0)
						#punch()
					
		elif focus.is_in_group('enemies'):
			if avoiding == true:
				focus_pos = focus.position
				dist = focus_pos.distance_to(position)
				if target_pos.distance_to(focus_pos) < target_pos.distance_to(position):
					#avoid_timer.start()
					vel = -(focus_pos - position).normalized() * speed
						#print('stop running away')
						#focus = target	
						#avoid_timer.start()
				else:
					avoiding = false
					chasing = true
				
			
			
		if focus.is_in_group('objects'):
			pass



func punch():
	if punchable == true:
		if sprite.frame == 0:
			sprite.frame += 3
			
			
		else:
			sprite.frame = 0
			
	
		
#		if sprite.frame != 5:
#			sprite.frame = 5
#		if sprite.frame == 5:
#			sprite.frame = 0

func anim():
	if vel != Vector2(0,0):
		if sprite.frame < 2:
			sprite.frame = sprite.frame + 1
		else:
			sprite.frame = 0




func _on_enemy_area_entered(area):
	if area.is_in_group('enemies'):
		#global.enemy_colliders.append(self)
		focus = area
		chasing = false
		sliding = false
		avoiding = true
	if area.is_in_group('players'):
		pass
	if area.is_in_group('objects'):
		focus = area
		chasing = false
		avoiding = false
		sliding = true
	
	
func _on_enemy_area_exited(area):

	if area == focus:
		if focus.is_in_group('enemies'):
			avoid_timer.start()
			avoid_ending = true
			
		#if avoid_timer.time_left > 0:
			
		
		#if focus.is_in_group('enemies'):
			#print(avoid_timer.time_left)
			#if avoid_timer.time_left == 0:
			#	print("yes")
			#avoiding = false
			#chasing = true
			#	print(focus.name)
		if focus.is_in_group('objects'):
			sliding = false
		

func _on_detect_radius_area_entered(area):
	if area.is_in_group('players'):
		target = area
		focus = target
		avoiding = false
		sliding = false
		chasing = true
		
func _on_overlap_rect_area_entered(area):
	#print(area.name)
	
	if area.position.y > position.y:
		if area.z_index > z_index:
			pass
		elif area.z_index <= z_index:
			area.z_index = z_index + 1
	if area.position.y < position.y:
		if area.z_index < z_index:
			pass
		elif area.z_index >= z_index:
			area.z_index = z_index -1
			

#z index for layering. higher y, higher z (godot does increasing y value as you go lower)
#don't overlap. use vector2 to determine if you are too close, also use z value to determine 
#"in front of" or "behind". then: stop and wait, or repath. same logic for overlapping player.
#only thing we need to add: if the object you are about to overlap is the player, start attacking.
#get state machine for motion up and running, then attacking.

func _on_punch_rect_area_entered(area):
	if area.is_in_group('players'):
		punchable = true
		#area.take_damage()
		
		


func _on_punch_rect_area_exited(area):
	if area.is_in_group('players'):
		punchable = false
		



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


#ATTACK VARIABLES
var punchable = false
var punch_timer



var colliding = false
var colliding_body



onready var sprite = get_node("sprite")
onready var unit

func _ready():
	unit = stats.hobo1_stats
	sprite.set_texture(unit.skin)
	self.add_to_group(unit.group)
	
	timer = Timer.new()
	timer.connect("timeout",self,"anim")
	add_child(timer)
	timer.wait_time = 0.2
	timer.start()
	
	
	punch_timer = Timer.new()
	punch_timer.connect("timeout",self,"punch")
	add_child(punch_timer)
	punch_timer.wait_time = 0.5
	punch_timer.start()
	
	

func _physics_process(delta):
	
	movement()
	position += vel * delta
	#check state, if state is seek: go to target the player. if obstructed, find obstruction type.
	#if type object, try moving. if type enemy, stop, do calc for timeout on move.
	#print(colliders)
	
	
	if vel.x > 0:
		scale.x = 1
	if vel.x < 0:
		scale.x = -1
	if vel.x == 0:
		sprite.frame = 0
		if target_pos.x > position.x:
			scale.x = 1
		else:
			scale.x = -1
			
	if chasing == true:
		focus = target
	
	if unit == stats.boss1_stats:
		pass
		

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
						punch()
					
		if focus.is_in_group('enemies'):
			if avoiding == true:
				focus_pos = focus.position
				dist = focus_pos.distance_to(position)
				if target_pos.distance_to(focus_pos) < target_pos.distance_to(position):
					vel = -(focus_pos - position).normalized() * speed
				else:
					avoiding = false
					chasing = true
				
			
			
		if focus.is_in_group('objects'):
			pass

func punch():
	if punchable == true:
		print('asdfasdfasdf')
		if sprite.frame != 5:
			sprite.frame = 5
		if sprite.frame == 5:
			sprite.frame = 0

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
			avoiding = false
			chasing = true
		if focus.is_in_group('objects'):
			sliding = false
		

func _on_detect_radius_area_entered(area):
	if area.is_in_group('players'):
		target = area
		focus = target
		avoiding = false
		sliding = false
		chasing = true
		


#z index for layering. higher y, higher z (godot does increasing y value as you go lower)
#don't overlap. use vector2 to determine if you are too close, also use z value to determine 
#"in front of" or "behind". then: stop and wait, or repath. same logic for overlapping player.
#only thing we need to add: if the object you are about to overlap is the player, start attacking.
#get state machine for motion up and running, then attacking.

func _on_punch_rect_area_entered(area):
	if area.is_in_group('players'):
		punchable = true
		print('punchable')


func _on_punch_rect_area_exited(area):
	if area.is_in_group('players'):
		punchable = false
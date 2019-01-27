extends Area2D


var timer
var speed = 100
var vel = Vector2()

var target
var target_pos = Vector2()
var direction
var dist

#var colliders = []

var colliding = false
var colliding_body
var _priority
var stfu = false

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
	
	randomize()
	_priority = rand_range(1,20)
#	print(priority)
	
	
	
	

func _physics_process(delta):
	movement()
	#if stfu == false:
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
			
	
#	if colliders.empty() == false:
#		for c in colliders:
#			var c_pos = c.position
#			if c_pos.distance_to(position) < 20:
#				#print('too close')
#				c.speed = 300
#				if c_pos.x > position.x:
#					c.speed = 300
#				elif c_pos.x <= position.x:
#					c.speed = rand_range(-1000,-600)
#
#			elif c_pos.distance_to(position) >= 20:
#				speed = 100
			
	
			
	if unit == stats.boss1_stats:
		pass
		
	

	
	
	
	
func movement():
#	if colliding == true:
#		#print('colliding')
#		#print(_priority)
#		#print(colliding_body._priority)
#		if dist > colliding_body.dist:
#			vel.x *= -100
#		if _priority < colliding_body._priority:
#			stfu = true
#		elif _priority > colliding_body.priority:
#			vel = vel * -.3
#	else:
#		stfu = false
	if target != null:
		dist = target_pos.distance_to(position)
		target_pos = target.position
		#if colliding == false:
		vel = (target_pos - position).normalized() * speed
		#elif colliding == true:
		#	disperse()
		if dist < 40:
			if abs(target_pos.y - position.y) < 20:
				vel = Vector2(0,0)
		#print(target_pos.distance_to(position))
		
		 
		


func anim():
	if vel != Vector2(0,0):
		if sprite.frame < 2:
			sprite.frame = sprite.frame + 1
		else:
			sprite.frame = 0




func _on_enemy_area_entered(area):
	#if area != self:
	if area.is_in_group('enemies'):
		#print('asdf')
		#print('asdf')
		colliding_body = area
		global.enemy_colliders.append(self)
		#print('collider added')
		colliding = true
	#print(area.name)
	if area.name == 'player':
		area.vel *= -100
	
func _on_enemy_area_exited(area):
	if area == colliding_body:
		colliding = false
		global.enemy_colliders.erase(self)
		#global.enemy_colliders.erase(colliding_body)
		#print('collider removed')

func _on_detect_radius_area_entered(area):
	if area.is_in_group('players'):
		target = area


#z index for layering. higher y, higher z (godot does increasing y value as you go lower)
#don't overlap. use vector2 to determine if you are too close, also use z value to determine 
#"in front of" or "behind". then: stop and wait, or repath. same logic for overlapping player.
#only thing we need to add: if the object you are about to overlap is the player, start attacking.
#get state machine for motion up and running, then attacking.
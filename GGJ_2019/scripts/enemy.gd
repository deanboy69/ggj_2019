extends Area2D


var timer
var speed = 100
var vel = Vector2()

#STATES
var chasing = false
var avoiding = false
var sliding = false
var focus		#	<--this variable allows player target to be preserved but changes immediate 'focus' to change depending on state
var target
var target_pos = Vector2()
var direction
var dist



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
			

	if unit == stats.boss1_stats:
		pass
		

func movement():
	if focus != null:
		if focus == target:
			dist = target_pos.distance_to(position)
			target_pos = target.position
			vel = (target_pos - position).normalized() * speed
			if dist < 40:
				if abs(target_pos.y - position.y) < 20:
					vel = Vector2(0,0)


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
	if area == colliding_body:
		colliding = false
		global.enemy_colliders.erase(self)

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
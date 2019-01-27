extends Area2D


var timer
var speed = 100
var vel = Vector2()

var target
var target_pos = Vector2()
var direction

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
	if stfu == false:
		position += vel * delta
	
	
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
	if colliding == true:
		#print('colliding')
		print(_priority)
		print(colliding_body._priority)
		if _priority < colliding_body._priority:
			stfu = true
		elif _priority > colliding_body.priority:
			vel = vel * -100
	else:
		stfu = false
	if target != null:
		target_pos = target.position
		vel = (target_pos - position).normalized() * speed
		if target_pos.distance_to(position) < 40:
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
		colliding = true
	#print(area.name)
	if area.name == 'player':
		area.vel *= -100
	
func _on_enemy_area_exited(area):
	if area == colliding_body:
		colliding = false

func _on_detect_radius_area_entered(area):
	if area.name == 'player':
		target = area

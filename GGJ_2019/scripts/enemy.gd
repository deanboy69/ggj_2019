extends Area2D


var timer
var speed = 100
var vel = Vector2()

var target
var target_pos = Vector2()
var direction

onready var sprite = get_node("sprite")

onready var unit

func _ready():
	unit = stats.hobo1_stats
	sprite.set_texture(unit.skin)
	
	
	timer = Timer.new()
	timer.connect("timeout",self,"anim")
	add_child(timer)
	timer.wait_time = 0.2
	timer.start()
	
	
	
	
	

func _physics_process(delta):
	movement()
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
	
	
	
	
func movement():
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




func _on_enemy_body_entered(body):
	pass
#	if body.name == 'player':
#		if position.x > body.position.x:
#
#		elif position.x <= body.position.x:
#			position.x -= 50


func _on_enemy_area_entered(area):
	print(area.name)


func _on_detect_radius_body_entered(body):
	if body.name == 'player':
		target = body

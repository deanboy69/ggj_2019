extends Node2D

onready var Scene1 = get_node("Scene1")
onready var Scene2 = get_node("Scene2")
onready var player = get_node("player")
onready var Next = get_node("NextLevel")
var Level1 = true
var Level2 = false
var speed = Vector2(0,0)
var speed2 = Vector2(0,0)
var did_shift = false
var can_add = true
export var scroll_speed = 0
export var scene_extents = 0
var level_can_spawn = true
var boss_spawned = false

const SCREEN_MIN_X = 0
const SCREEN_MAX_X = 1000
const SCREEN_MIN_Y = 0
const SCREEN_MAX_Y = 600

onready var boss_spawner = get_node('Boss_scene')
onready var hobo_spawner = get_node('Level_1')



# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	set_process_input(true)
	

func _process(delta):
	player.position.x = clamp(player.position.x, 60, SCREEN_MAX_X)
	player.position.y = clamp(player.position.y, 250, SCREEN_MAX_Y-80)
	Scene1.position += speed
	Scene2.position += speed2
	if Scene1.position.x <= -scene_extents:
		Level2 = true
		global.shift_level = false
		speed = Vector2(0,0)
		speed2 = Vector2(0,0)
		#print('can move scene!')
		Scene1.position.x = 1037
		Next.position.x = 984
		global.can_move = true
		level_can_spawn = true
	var dist = player.position.x - Next.position.x
	if dist >= -5:
		if global.shift_level == false && Level2 == false && can_add == true:
			global.shift_level = true
			global.can_move = false
			can_add = false ##need to add conditional HERE
		if Level2 == false && global.scene_num <=3:
			speed = Vector2(scroll_speed,0)
			speed2 = Vector2(scroll_speed,0)
			Next.position += Vector2(-10,0)
			player.position += Vector2(-10,0)
			did_shift = true
			if Scene2.position.x <= 200:
				Level2 = false
				global.shift_level = false
				Level1 = false
				global.can_move = false
				level_can_spawn = true
			if global.scene_num == 0 && level_can_spawn == true:
				spawn_level_1()
				level_can_spawn = false

		
					#player.position = Vector2(0,0)	
		if global.shift_level == false && Level1 == false && can_add == true:
			global.shift_level = true
			can_add = false ##need to add conditional HERE
			global.can_move = false
		##if global.scene_num > 29 && global.scene_num< 31 && level_can_spawn == true:
##			spawn_level_2()
##			level_can_spawn = false
	
		if Level1 == false:
			speed = Vector2(scroll_speed,0)
			speed2 = Vector2(scroll_speed,0)
			Next.position += Vector2(-10,0)
			player.position += Vector2(-10,0)
			did_shift = true
			if Scene1.position.x <= 200:
				Level1 = false
				global.shift_level = false
				Level2 = false
				global.can_move = false
				level_can_spawn = true
					#player.position = Vector2(0,0)
					
	if dist < -5 and Level2 == false :
		#print("stop")
		#global.shift_level = false
		speed = Vector2(0,0)
		speed2 = Vector2(0,0)
		player.position += Vector2(0,0)
		
	if Scene2.position.x <= -scene_extents:
		Level1 = true
		global.shift_level = false
		speed = Vector2(0,0)
		speed2 = Vector2(0,0)
		#print('can move scene!')
		Scene2.position.x = 1037
		Next.position.x = 984
		level_can_spawn = true
		print('fuckadilly')
		if global.scene_num > 20 && level_can_spawn == true && boss_spawned == false:
			spawn_level_3()
			level_can_spawn = false
			boss_spawned = true

					
	if dist < -5 and Level1 == false :
		#print("stop")
		#global.shift_level = false
		speed = Vector2(0,0)
		speed2 = Vector2(0,0)
		player.position += Vector2(0,0)
		
	#if elf2.position.x <= 514:
	#	speed2 = Vector2(0,0)
	#if elf.position.x <= -514:
	#	speed = Vector2(0,0)
	#if elf.position.x >=514:
#	speed = Vector2(0,0)
	#if elf2.position.x >= 1530:
	#	speed2 = Vector2(0,0)
	pass

#func transition():
#	var dist = player.position.x - Next.position.x
#	if dist >= -5:
#		global.shift_level = true
#	if Level2 == false:
#		#speed += Vector2(-.2,0)
#		#speed2 += Vector2(-.2,0)
#		Next.position += Vector2(-10,0)
#		player.position += Vector2(-10,0)
#		global.shift_level = true
#	if dist < -5 and Level2 == false :
#		#print("stop")
#		#global.shift_level = false
#		speed = Vector2(0,0)
#		speed2 = Vector2(0,0)
#		player.position += Vector2(0,0)	
func spawn_level_1():
	print('level_1_spawned')
	hobo_spawner.position.x = 0
func spawn_level_2():
	print('level_2_spawned')
func spawn_level_3():
	boss_spawner.position.x = 0
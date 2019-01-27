extends Node2D

onready var elf = get_node("ELF")
onready var elf2 = get_node("ELF2")
onready var player = get_node("player")
onready var Next = get_node("NextLevel")
var Level2 = false
var speed = Vector2(0,0)
var speed2 = Vector2(0,0)

const SCREEN_MIN_X = 0
const SCREEN_MAX_X = 1000
const SCREEN_MIN_Y = 0
const SCREEN_MAX_Y = 600



# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
 set_process(true)
 set_process_input(true)

func _process(delta):
	player.position.x = clamp(player.position.x, 60, SCREEN_MAX_X)
	player.position.y = clamp(player.position.y, 60, SCREEN_MAX_Y-80)
	elf.position += speed
	elf2.position += speed2
	if elf2.position.x <= 517:
		Level2 = true
		global.shift_level = false
		
	if Level2 == true:
		speed2 = Vector2(0,0)
		
	
	
	
	
	var dist = player.position.x - Next.position.x
	if dist >= -6 and Level2 == false:
		#print("next level")
		#global.shift_level = true
		speed += Vector2(-.05,0)
		speed2 += Vector2(-.05,0)
		#Next.position += Vector2(-5,0)
		player.position += Vector2(-2,0)
		global.shift_level = false
	if dist < -5:
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




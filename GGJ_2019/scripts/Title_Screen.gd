extends Node2D

onready var elf = get_node("ELF")
onready var elf2 = get_node("ELF2")
var speed = Vector2(0,0)
var speed2 = Vector2(0,0)
onready var IntroMusic = get_node("IntroMusic")

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
 set_process(true)
 set_process_input(true)
 IntroMusic.play()

func _process(delta):
	elf.position += speed



func _on_Start_pressed():
	print("hi")
	get_tree().change_scene("res://scenes/First_level.tscn")
	
	
	 # replace with function body


func _on_End_Game_pressed():
	print("yo")
	get_tree().quit()



func _on_Options_pressed():
	get_tree().change_scene("res://scenes/Options_menu.tscn")
	pass # replace with function body


func _on_Button_pressed():
	print("shift")
	speed += Vector2(-15,0)
	speed2 += Vector2(-15,0)
	
	# elf.position += Vector2(-5,-5) * delta 
	
	# elf.position = Vector2(-500,-299.955994)
	# elf2.position = Vector2(514,299.955994)
	pass # replace with function body

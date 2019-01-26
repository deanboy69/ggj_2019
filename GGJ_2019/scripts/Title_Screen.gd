extends Node2D

onready var elf = get_node("ELF")
onready var elf2 = get_node("ELF2")
var speed = Vector2(0,0)
var speed2 = Vector2(0,0)
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
 set_process(true)
 set_process_input(true)

func _process(delta):
	elf.position += speed
	elf2.position += speed2
	if elf2.position.x <= 514:
		speed2 = Vector2(0,0)



func _on_Start_pressed():
	print("hi")
	elf.modulate = Color(.2,.1,.3,.5)
	
	
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

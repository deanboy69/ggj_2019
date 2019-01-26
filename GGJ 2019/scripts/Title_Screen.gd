extends Node2D

onready var elf = get_node("ELF")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
 set_process(true)
 set_process_input(true)

func _process(delta):
	pass
	



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

	pass # replace with function body

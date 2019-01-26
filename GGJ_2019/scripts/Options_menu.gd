extends Node2D

onready var elf = get_node("Background")

func _ready():
 set_process(true)
 set_process_input(true)

func _process(delta):
	pass



func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Title_Screen.tscn")
	pass # replace with function body


func _on_IncreaseBright_pressed():
	print("Increase")
	elf.modulate = Color(1,1,1,1)


func _on_DecreaseBright_pressed():
	print("Decrease")
	elf.modulate = Color(.2,.1,.3,.5)

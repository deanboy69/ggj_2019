extends Node2D

onready var Scene1 = get_node("Scene1")
onready var Scene2 = get_node("Scene2")
onready var Scene3 = get_node("Scene3")
var speed = Vector2(-2,0)
var speed2 = Vector2(-2,0)
var speed3 = Vector2(-2,0)

func _ready():
	
	pass

func _process(delta):
	Scene1.position += speed
	Scene2.position += speed2
	Scene3.position += speed3

	pass

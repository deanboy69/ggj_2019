extends KinematicBody2D




onready var sprite = get_node("sprite")

onready var unit

func _ready():
	unit = stats.hobo1
	sprite.set_texture(unit.skin)

func _physics_process(delta):
	pass

extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var hobo1 = {'health':100,'punch':10,'kick':15,'skin':1}
onready var hobo2 = {'health':100,'punch':10,'kick':15,'skin':2}
onready var boss1 = {'health':150,'punch':20,'kick':30,'skin':1}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	pass

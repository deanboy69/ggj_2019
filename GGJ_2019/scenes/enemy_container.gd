extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	#print(global.enemy_colliders)
	for i in range(0,global.enemy_colliders.size()):
		print(i)#enemy in global.enemy_colliders:
		#if enemy.colliding == true:
			


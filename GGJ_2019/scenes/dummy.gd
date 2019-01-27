extends Area2D

onready var unit


func _ready():
	unit = stats.player_stats
	self.add_to_group(unit.group)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

extends Node2D

onready var bar = get_node('TextureProgress')

func _ready():
	bar.max_value = global.player_health

func _process(delta):
	bar.value = global.player_health
	
	   
    #update_health(player_max_health)


#func _on_Player_health_changed(player_health):
    #update_health(player_health)

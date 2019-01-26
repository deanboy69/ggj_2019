extends Node

onready var player = get_node("player")
onready var player_pos = Vector2(225.5, 31)	#		<--- set to something correct for hex grid
#	load surface, shallow, and deep layers
onready var surface_scene = load("res://scenes/iso_surface1.tscn")
onready var shallow_scene = load("res://scenes/iso_shallow1.tscn")
onready var deep_scene = load("res://scenes/iso_deep1.tscn")
onready var tilemap

onready var enemy_spawns = get_node("enemy_spawns")
onready var spawn_pos1 = get_node("enemy_spawns/spawn_pos1")
onready var spawn_pos2 = get_node("enemy_spawns/spawn_pos2")

onready var enemy1 = load("res://scenes/enemy1.tscn")


#	'sea_level' will determine whether the tilemap needs to change
var sea_level = 0

var enemies_list = []

func _ready():
	player.set_position(player_pos)
	tilemap = surface_scene.instance()
	add_child(tilemap)
	for i in enemy_spawns.get_children():
		var e1 = enemy1.instance()
		add_child(e1)
		e1.set_global_position(i.get_global_position())
		enemies_list.append(e1)
	for i in range(0, len(enemies_list)):
		enemies_list[i].ID = i + 1


	
#	called in _process when 'sea_level' does not correspond with 'player.depth'
#	the correct tilemap is instanced and added as a child to the scene
#	the old tilemap is deleted in the _process function
func switch_depths():
	if sea_level == 0:
		tilemap = surface_scene.instance()
	elif sea_level == -1:
		tilemap = shallow_scene.instance()
	elif sea_level == -2:
		tilemap = deep_scene.instance()
	add_child(tilemap)
		

#	what's going on here is a constant update of whether 'sea_level' and 'player.depth' align
#	if misaligned, _process corrects it by removing the old tilemap and calling the switch_depths function
func _process(delta):
	if sea_level == 0:
		if player.depth != "surface":
			for map in get_tree().get_nodes_in_group("tilemaps"):
				map.queue_free()
			sea_level -= 1
			switch_depths()
	elif sea_level == -1:
		if player.depth != "shallow":
			if player.depth == "surface":
				for map in get_tree().get_nodes_in_group("tilemaps"):
					map.queue_free()
				sea_level += 1
			elif player.depth == "deep":
				for map in get_tree().get_nodes_in_group("tilemaps"):
					map.queue_free()
				sea_level -= 1
			switch_depths()
	elif sea_level == -2:
		if player.depth != "deep":
			for map in get_tree().get_nodes_in_group("tilemaps"):
				map.queue_free()
			sea_level += 1
			switch_depths()


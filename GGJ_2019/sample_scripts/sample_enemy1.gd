extends KinematicBody2D

const SPEED = 10

onready var pos_container = get_node("pos_container")
onready var U = get_node("pos_container/U")
onready var UR = get_node("pos_container/UR")
onready var DR = get_node("pos_container/DR")
onready var D = get_node("pos_container/D")
onready var DL = get_node("pos_container/DL")
onready var UL = get_node("pos_container/UL")
onready var detectU = get_node("pos_container/U/detectU")
onready var detectUR = get_node("pos_container/UR/detectUR")
onready var detectDR = get_node("pos_container/DR/detectDR")
onready var detecdtD = get_node("pos_container/D/detectD")
onready var detectDL = get_node("pos_container/DL/detectDL")
onready var detectUL = get_node("pos_container/UL/detectUL")
onready var dinghy = get_node("dinghy")

onready var body_area = get_node("body_area")



#TEMPORARY#
onready var spriteU = get_node("pos_container/U/Sprite")
onready var spriteUR = get_node("pos_container/UR/Sprite")
onready var spriteDR = get_node("pos_container/DR/Sprite")
onready var spriteD = get_node("pos_container/D/Sprite")
onready var spriteDL = get_node("pos_container/DL/Sprite")
onready var spriteUL = get_node("pos_container/UL/Sprite")




var ID

var idle = true
var target = null
var target_pos = Vector2()

var pos = Vector2()
var vel = Vector2()
var list_positions = []#[Vector2(), Vector2(), Vector2(), Vector2(), Vector2(), Vector2(),
					#Vector2(), Vector2()]
var list_closest_pos = []
var move_count = 0
var pos_index
var pos_index2
var nearest_pos
var nearest_pos_coord = Vector2()

var reverse_list = 0
var rot = 0

var next_pos = Vector2()

var fellows = []
var shwarma = null
var shwarma2


var stay_still = false

var first_nearest = false
var second_nearest = true


func movement():
	
	#This makes sure the enemy isn't always trying to move, makes it more turn-based
	if move_count < global.move_count:

		move_count += 1
		stay_still = false
		#this populates a list of all the 6 position2d's for the enemy
		list_positions = []
		for i in range(0, 6):
			list_positions.append([])
			list_positions[i].append(pos_container.get_child(i))
			var p_pos = list_positions[i][0].get_global_position()
			list_positions[i].append(p_pos)
		
		if idle == false:		#i.e. if player has been detected
			if target != null:
				target_pos = target.get_global_position()
				list_closest_pos = []
				for i in range(0, 6):
					var proximity = list_positions[i][1].distance_to(target_pos)
					list_closest_pos.append(proximity)
			find_min(list_closest_pos)		#i.e. find the closest position2d to the player
			nearest_pos = list_positions[pos_index][0].get_child(0).get_overlapping_bodies()
			nearest_pos_coord = list_positions[pos_index][1]		#get the coordinates of this position
			if nearest_pos_coord.distance_to(target_pos) >= 89:		#i.e. if the player is somewhat far away
				if nearest_pos.empty() == true:
					next_pos = nearest_pos_coord
				elif nearest_pos.empty() == false:
					if not nearest_pos[0].is_in_group("tilemaps"):
						first_nearest = true
						second_nearest = false
						#if not nearest_pos[0].is_in_group("enemies"):
						next_pos = nearest_pos_coord
					else:
						first_nearest = false
						second_nearest = true
						nearest_pos = list_positions[pos_index2][0].get_child(0).get_overlapping_bodies()
						nearest_pos_coord = list_positions[pos_index2][1]
						if nearest_pos_coord.distance_to(target_pos) >= 50:
							if nearest_pos.empty() == true:
								next_pos = nearest_pos_coord
							elif nearest_pos.empty() == false:
								if not nearest_pos[0].is_in_group("tilemaps"):
									#if not nearest_pos[0].is_in_group("enemies"):
									next_pos = nearest_pos_coord
								else:
									next_pos = Vector2(-300, -300)
			#reverse_list = list_positions.find([pos_index][nearest_pos_coord])
			#shwarma = list_positions[pos_index][0]
			#print(nearest_pos_coord)
			#print(list_positions)
			#print(shwarma)
			#var shwarma2 = list_positions[pos_index][0].get_child(0).get_overlapping_areas()
			#for i in range(0, len(shwarma2)):
			#	if shwarma2[i].is_in_group("enemy_detectors"):
			#		print(shwarma2[i])
			
		avoid_fellows()


	
func avoid_fellows():
	
	#shwarma = list_positions[pos_index][0].get_child(1)
	#shwarma.show()
	
	if idle == false:
		shwarma = list_positions[pos_index][0].get_child(0)
		shwarma2 = shwarma.get_overlapping_areas()
		for i in range(0, len(shwarma2)):
			if shwarma2[i].is_in_group("enemy_detectors"):
				if shwarma2[i].get_overlapping_areas().has(shwarma):# == shwarma:
					if shwarma2[i].get_parent().get_parent().get_parent().shwarma == shwarma2[i]:
						print("badabing")
						#if shwarma2[i].get_parent().get_parent().get_parent().ID > ID:
						stay_still = true
						shwarma2[i].get_parent().get_parent().get_parent().stay_still = true

					#if ID >= 
			if shwarma2[i].is_in_group("enemy_bodies"):
				if shwarma2[i].get_overlapping_areas().has(shwarma):
					#print("dadading")
					stay_still = true
		#if shwarma2.empty() == false:
		#	for i in range(0, len(shwarma2)):
		#		if shwarma2[i].get_overlapping_areas() 
	
	#for i in range(0, len(shwarma2)):
		#if shwarma2[i]
		#if shwarma == fellows[i].list_positions[pos_index][0].get_position():
			#stay_still = true
		#else:
			#stay_still = false



func follow_fellows():
	pass
	
	
#U = 0
#
#UR = 45
#
#DR = 135
#
#D = 180
#
#DL = 225
#
#UL = 315
func rotate_dinghy():
	var rot_coords = Vector2(int(nearest_pos_coord.x - pos.x), int(nearest_pos_coord.y - pos.y))
	if rot_coords == Vector2(-84, -30):
		rot = 315
	elif rot_coords == Vector2(84, -30):
		rot = 45
	elif rot_coords == Vector2(-84, 30):
		rot = 225
	elif rot_coords == Vector2(84, 30):
		rot = 135
	elif rot_coords == Vector2(0, -60):
		rot = 0
	elif rot_coords == Vector2(0, 60):
		rot = 180
	if abs(vel.x) >= 1 or abs(vel.y) >= 1:
		dinghy.rotation_degrees = rot

func find_min(array):
	var min_val = array[0]
	for i in range(1, array.size()):
		min_val = min(min_val, array[i])
	pos_index = array.find(min_val)
	array.remove(pos_index)
	var min_val2 = array[0]
	for i in range(1, array.size()):
		min_val2 = min(min_val2, array[i])
	pos_index2 = list_positions.find(min_val2)
	

	
func _process(delta):
	pos = get_global_position()
	movement()
	rotate_dinghy()
	#avoid_fellows()
	#if next_pos != Vector2(-300, -300):
	#	vel = Vector2((next_pos.x - pos.x), (next_pos.y - pos.y))
	#	pos += vel * delta
	if stay_still == false:
		if next_pos.x > 0 or next_pos.y > 0:
			vel = Vector2(int(next_pos.x - pos.x), int(next_pos.y - pos.y)) * SPEED
			pos += vel * delta
			set_global_position(pos)




func _on_detect_radius_body_entered(body):
	if body != self:
		if body.is_in_group("player"):
			idle = false
			target = body
		if body.is_in_group("enemies"):
			fellows.append(body)
		
func _on_detect_radius_body_exited(body):
	if body.is_in_group("player"):
		idle = true
		print("gone")

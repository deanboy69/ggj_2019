extends KinematicBody2D


const SPEED = 10

#	adding all of the scene's nodes that will be referenced as variables here

onready var detect_U = get_node("detect_U")
onready var detect_D = get_node("detect_D")
onready var detect_UR = get_node("detect_UR")
onready var detect_DR = get_node("detect_DR")
onready var detect_DL = get_node("detect_DL")
onready var detect_UL = get_node("detect_UL")
onready var whale = get_node("whale")

onready var button_U = get_node("button_U")
onready var button_UR = get_node("button_UR")
onready var button_DR = get_node("button_DR")
onready var button_D = get_node("button_D")
onready var button_DL = get_node("button_DL")
onready var button_UL = get_node("button_UL")

onready var path_yes_texture = "res://images/yes.png"
onready var path_pressed_texture = "res://images/pressed.png"
onready var path_no_texture = "res://images/no.png"

onready var yes_texture = load("res://images/yes.png")
onready var pressed_texture = load("res://images/pressed.png")
onready var no_texture = load("res://images/no.png")

onready var move_timer = get_node("move_timer")



#	variable 'dir' will help determine whether a space is movable;
#	defaulting as 'nextmoveU' because cannot be null
onready var dir = button_U

#	variable 'next_pos' will determine where the player goes, if square is green;
#	defaulting as -80,-80 because cannot be null and this position is not on the map
var next_pos = Vector2(-300, -300)
#	determines depth player should be in
var depth = "surface"

var rot = 0
var vel = Vector2()
var pos = Vector2()


func show_hide_buttons():
	for i in get_tree().get_nodes_in_group("buttons"):
		if abs(vel.x) >= 1 or abs(vel.y) >= 1:
			i.hide()
		else:
			i.show()




#	NUMPAD REQUIRED. whichever is pressed, if corresponding square is green,
#	player will move there. also, whale sprite rotates accordingly
func player_input():
#	-/+ changes depth
	if Input.is_action_just_released("_depthU"):
		if depth == "surface":
			pass
		elif depth == "shallow":
			depth = "surface"
		elif depth == "deep":
			depth = "shallow"
		print(depth)
	if Input.is_action_just_released("_depthD"):
		if depth == "surface":
			depth = "shallow"
		elif depth == "shallow":
			depth = "deep"
		elif depth == "deep":
			pass
		print(depth)
		

		

#	standard physics process, calls player_input function
func _physics_process(delta):
	pos = get_global_position()
	player_input()
	show_hide_buttons()
	#	moves the player to designated spot
	#if dir.get_texture().get_path() == path_yes_texture:
	if next_pos != Vector2(-300, -300):

		vel = Vector2((next_pos.x - get_global_position().x), (next_pos.y - get_global_position().y)) * SPEED
		pos += vel * delta

		set_global_position(pos)

	
	
	


	
#DETECTIONS
#	detect if can move to top space
func _on_detect_up_body_entered(body):
	if body != self:
		button_U.set_texture(no_texture)
func _on_detect_up_body_exited(body):
	if body != self:
		button_U.set_texture(yes_texture)
#	detect if can move to bottom space
func _on_detect_down_body_entered(body):
	if body != self:
		button_D.set_texture(no_texture)
func _on_detect_down_body_exited(body):
	if body != self:
		button_D.set_texture(yes_texture)
#	detect if can move to top right space
func _on_detect_UR_body_entered(body):
	if body != self:
		button_UR.set_texture(no_texture)
func _on_detect_UR_body_exited(body):
	if body != self:
		button_UR.set_texture(yes_texture)
#	detect if can move to bottom right space
func _on_detect_DR_body_entered(body):
	if body != self:
		button_DR.set_texture(no_texture)
func _on_detect_DR_body_exited(body):
	if body != self:
		button_DR.set_texture(yes_texture)
#	detect if can move to bottom left space
func _on_detect_DL_body_entered(body):
	if body != self:
		button_DL.set_texture(no_texture)
func _on_detect_DL_body_exited(body):
	if body != self:
		button_DL.set_texture(yes_texture)
#	detect if can move to top left space
func _on_detect_UL_body_entered(body):
	if body != self:
		button_UL.set_texture(no_texture)
func _on_detect_UL_body_exited(body):
	if body != self:
		button_UL.set_texture(yes_texture)




func _on_button_U_released():
	#if move_timer.get_time_left() == 0:
	#	move_timer.start()
	dir = button_U
	rot = 0
	whale.rotation_degrees = rot
	if dir.get_texture().get_path() == path_yes_texture:

		next_pos = detect_U.get_global_position()
		global.move_count += 1
		#print(global.move_count)
	else:

		next_pos = get_global_position()



func _on_button_UR_released():
	if move_timer.get_time_left() == 0:
		move_timer.start()
		dir = button_UR
		rot = 45
		whale.rotation_degrees = rot
		if dir.get_texture().get_path() == path_yes_texture:
			next_pos = detect_UR.get_global_position()
			global.move_count += 1
			#print(global.move_count)
		else:
			next_pos = get_global_position()


func _on_button_DR_released():
	if move_timer.get_time_left() == 0:
		move_timer.start()
		dir = button_DR
		whale.rotation_degrees = 135
		if dir.get_texture().get_path() == path_yes_texture:
			next_pos = detect_DR.get_global_position()
			global.move_count += 1
			#print(global.move_count)
		else:
			next_pos = get_global_position()


func _on_button_D_released():
	if move_timer.get_time_left() == 0:
		move_timer.start()
		dir = button_D
		rot = 180
		whale.rotation_degrees = rot
		if dir.get_texture().get_path() == path_yes_texture:
			next_pos = detect_D.get_global_position()
			global.move_count += 1
			#print(global.move_count)
		else:
			next_pos = get_global_position()


func _on_button_DL_released():
	if move_timer.get_time_left() == 0:
		move_timer.start()
		dir = button_DL
		rot = 225
		whale.rotation_degrees = rot
		if dir.get_texture().get_path() == path_yes_texture:
			next_pos = detect_DL.get_global_position()
			global.move_count += 1
			#print(global.move_count)
		else:
			next_pos = get_global_position()


func _on_button_UL_released():
	if move_timer.get_time_left() == 0:
		move_timer.start()
		dir = button_UL
		rot = 315
		whale.rotation_degrees = rot
		if dir.get_texture().get_path() == path_yes_texture:
			next_pos = detect_UL.get_global_position()
			global.move_count += 1
			#print(global.move_count)
		else:
			next_pos = get_global_position()

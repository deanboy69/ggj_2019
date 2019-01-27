extends Node

var shift_level = false

var enemy_colliders = []

var colliding_vels = [Vector2(-100,100),Vector2(-100,-100),Vector2(100,100),Vector2(100,-100)]

var scene_num = 0
var game_over = false
var endgame = false
var stage_1_beaten = 0
var stage_2_beaten = 0
var stage_3_beaten = 0
var final_stage_beaten = 0
# += 1 when completing, += 1 more once beaten. stage_2 only unlocks when stage_1 = 2 etc.

#if final_stage_beaten == 2:
#	endgame = true


var player_health = 15
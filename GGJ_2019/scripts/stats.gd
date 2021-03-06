extends Node

var player_stats = {'health':15,'punch':10,'kick':15,
					'group':'players',					
					'skin': preload('res://images/skins/player/player_char_atlas.png'),
					'death': preload("res://images/skins/player/player_death.png")}
var hobo1_stats = {'health':3,'punch':10,'kick':15,
					'group':'enemies',
					'skin': preload('res://images/skins/hobo1/hobo1_char_atlas.png'),
					'death': preload("res://images/skins/hobo2/hobo2_death.png")}
var hobo2_stats = {'health':4,'punch':10,'kick':15,
					'group':'enemies',
					'skin':preload('res://images/skins/hobo2/hobo1_char_atlas.png'),
					'death': preload("res://images/skins/hobo1/hobo1_death.png")}
var goon1_stats = {'health':5,'punch':10,'kick':15,
					'group':'enemies',
					'skin':preload('res://images/skins/goon1/goon_atlas.png'),
					'death': preload('res://images/skins/goon1/goon_death.png')}
var boss1_stats = {'health':7,'punch':20,'kick':30,
					'group':'enemies',
					'skin':preload('res://images/skins/boss1/boss_atlas.png'),
					'death': preload('res://images/skins/boss1/boss1_death.png')}
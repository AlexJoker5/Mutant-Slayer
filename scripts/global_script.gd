extends Node


#stats
var enemy_death_count = 0
var level = 1
var level_win_state = 30
var unlock_lvl2 = false
var unlock_lvl3 = false


#player
var player_Maxhealth = 700
var player_health
var player_Maxmana = 400
var player_mana
var player_speed = 90
var Player_pos
var player_attack_Damage = 60
var player_MaxEnergy = 100
var player_energy
var dash_energy = 40
signal dash(value)
signal playerHit_enemy(value)


#spell signal
var spell1_cooldown = 10
var spell2_cooldown = 15
var spell3_cooldown = 30

signal spell_1_used
signal spell_2_used
signal spell_3_used
signal spell_1_ready
signal spell_2_ready
signal spell_3_ready

var spell1_mana = 80
var spell2_mana = 125
var spell3_mana = 225
var spell1_enough_mana = true
var spell2_enough_mana = true
var spell3_enough_mana = true

var spell1_damage = 130
var spell2_damage = 25
var spell3_damage = 250


#Gnoll
signal Gnollhit_player(dm)
var Gnoll_pos
var Gnoll_health = 200 #not connected for now
var Gnollhit_dm = 35
var GnollBlue_dm = 35
var GnollRed_dm = 60

#Gems
var healthGem_heal = 40
var manaGem_heal = 20
signal healthGem_collected
signal manaGem_collected

#Countdown
onready var game_start_time = OS.get_ticks_msec()
var timer_on = false

#score
var score = 0

func _ready():
	load_level()
	
func load_level():
	print("Loading...")

	var save_file = File.new()
	if not save_file.file_exists("user://savefile.save"):
		save_level()
		return
	save_file.open("user://savefile.save", File.READ)
	var data = save_file.get_var()
	unlock_lvl2 = data["unlock_lvl2"]
	unlock_lvl3 = data["unlock_lvl3"]
	save_file.close()
	
func save_level():
	print("Saving...")
	var data = {
		"unlock_lvl2": unlock_lvl2,
		"unlock_lvl3": unlock_lvl3
	}
	var save_file = File.new()
	save_file.open("user://savefile.save", File.WRITE)
	save_file.store_var(data)
	save_file.close()
	load_level()

extends Node


#stats
var enemy_death_count = 0


#player
var player_Maxhealth = 600
var player_health
var player_Maxmana = 300
var player_mana
var player_speed = 150
var Player_pos
var player_attack_Damage = 60

#spell signal
var spell1_cooldown = 6
var spell2_cooldown = 10
var spell3_cooldown = 20

signal spell_1_used
signal spell_2_used
signal spell_3_used
signal spell_1_ready
signal spell_2_ready
signal spell_3_ready

var spell1_mana = 100
var spell2_mana = 150
var spell3_mana = 200
var spell1_enough_mana = true
var spell2_enough_mana = true
var spell3_enough_mana = true

var spell1_damage = 120
var spell2_damage = 15
var spell3_damage = 250


#Gnoll
signal Gnollhit_player(dm)
var Gnoll_pos
var Gnoll_health = 200 #not connected for now
var Gnollhit_dm = 50
var GnollBlue_dm = 50
var GnollRed_dm = 80

#Gems
var healthGem_heal = 25
var manaGem_heal = 10
signal healthGem_collected
signal manaGem_collected



func _ready():
	pass


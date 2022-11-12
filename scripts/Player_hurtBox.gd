extends Area2D

const HitEffect = preload("res://scenes/Effects/HitEffect.tscn")
const HealEffect = preload("res://scenes/Effects/HealEffect.tscn")
const ManaEffect = preload("res://scenes/Effects/ManaEffect.tscn")
var Gnoll_Damage = preload("res://scripts/Enemy/Gnoll.gd")



func _ready():
	pass 

var Gnoll_dm = GlobalScript.Gnollhit_dm
var GnollRed_dm = GlobalScript.GnollRed_dm
signal Gnoll_knock_player
signal GnollBlue_slow(value)

func _on_Player_hurtBox_area_entered(area):
	var effect_instance = HitEffect.instance()
	var main = get_tree().current_scene
	
	
	if area.is_in_group("Gnoll_hitBox"):
		GlobalScript.emit_signal("Gnollhit_player",GlobalScript.Gnollhit_dm)
		emit_signal("Gnoll_knock_player")
		main.add_child(effect_instance)
		effect_instance.global_position = global_position
	elif area.is_in_group("Gnoll_red_hitbox"):
		GlobalScript.emit_signal("Gnollhit_player",GlobalScript.GnollRed_dm)
		emit_signal("Gnoll_knock_player")
		main.add_child(effect_instance)
		effect_instance.global_position = global_position
	elif area.is_in_group("Gnollblue_hitbox"):
		GlobalScript.emit_signal("Gnollhit_player",GlobalScript.GnollBlue_dm)
		emit_signal("Gnoll_knock_player")
		emit_signal("GnollBlue_slow",GlobalScript.player_speed*0.6)
		main.add_child(effect_instance)
		effect_instance.global_position = global_position
	elif area.is_in_group("HealthGem"):
		var Heal_instance = HealEffect.instance()
		var main_heal = get_tree().get_root().get_node("/root/Level_1/Player")
		main_heal.add_child(Heal_instance)
		Heal_instance.global_position = global_position
	elif area.is_in_group("ManaGem"):
		var Mana_instance = ManaEffect.instance()
		var main_mana = get_tree().get_root().get_node("/root/Level_1/Player")
		main_mana.add_child(Mana_instance)
		Mana_instance.global_position = global_position

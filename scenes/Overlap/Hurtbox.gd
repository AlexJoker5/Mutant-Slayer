extends Area2D

const HitEffect = preload("res://scenes/Effects/HitEffect.tscn")

var invincible = false setget set_invincible

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D
var attack_damage = GlobalScript.player_attack_Damage
var spell1_damage = GlobalScript.spell1_damage
var spell2_damage = GlobalScript.spell2_damage
var spell3_damage = GlobalScript.spell3_damage

signal invincibility_started
signal invincibility_ended
signal damage_taken(damage)
signal dps_taken(damage)
signal player_knock_Gnoll(knock_value)


func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
	
func start_invincibility (duration):
	self.invincible = true
	timer.start(duration)

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_Timer_timeout():
	self.invincible = false

func _on_Hurtbox_invincibility_started():
	collisionShape.set_deferred("disable",true)
	
func _on_Hurtbox_invincibility_ended():
	collisionShape.disabled = false


func _on_Hurtbox_area_entered(area):
	var effect_instance = HitEffect.instance()
	var main = get_tree().current_scene
	if area.is_in_group("Player_Attack"):
		emit_signal("player_knock_Gnoll",50)
		emit_signal("damage_taken",attack_damage)
		main.add_child(effect_instance)
		effect_instance.global_position = global_position
	elif area.is_in_group("spell_1"):
		print("spell 1 hit")
		emit_signal("player_knock_Gnoll",100)
		emit_signal("damage_taken",spell1_damage)
		main.add_child(effect_instance)
		effect_instance.global_position = global_position
	elif area.is_in_group("spell_2"):
		print("spell 3 hit")
		emit_signal("player_knock_Gnoll",200)
		emit_signal("damage_taken",spell3_damage)
		main.add_child(effect_instance)
		effect_instance.global_position = global_position
	elif area.is_in_group("spell_3"):
		emit_signal("dps_taken",spell2_damage)






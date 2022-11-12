extends Control

onready var health_bar = $hp_bar


signal no_health

	
func _process(delta):
	var total_health = health_bar.max_value
	var current_health = health_bar.value
	if health_bar.value <= 0:
		emit_signal("no_health")
	#print(health_bar.value)

func _on_health_updated(health, amount):
	health_bar.value = health
	
func _on_max_health_updated(max_health):
	health_bar.max_value = max_health




func _on_Hurtbox_damage_taken(damage):
	health_bar.value -= damage

var deal_dps = true
func _on_Hurtbox_dps_taken(damage):
	deal_dps = true
	while deal_dps:
		health_bar.value -= damage
		yield(get_tree().create_timer(1),"timeout")


func _on_Hurtbox_area_exited(area):
	if area.is_in_group("spell_3"):
		deal_dps = false

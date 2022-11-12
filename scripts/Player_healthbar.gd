extends Control


onready var health_bar = $Health_bar
signal player_noHealth

func _ready():
	health_bar.max_value = GlobalScript.player_Maxhealth
	health_bar.value = health_bar.max_value
	GlobalScript.player_health = health_bar.value
	GlobalScript.connect("healthGem_collected",self,"_healthGem_collected")
	GlobalScript.connect("Gnollhit_player",self,"_on_Player_hurtBox_Gnoll_hit_player")

func _process(delta):
	var total_health = health_bar.max_value
	var current_health = health_bar.value
	$Container/total_health.text = str(str(current_health)+"/"+str(total_health))
	GlobalScript.player_health = health_bar.value
	
func _on_health_updated(health,amount):
	health_bar.value = health
	
	

func _on_max_health_updated(max_health):
	health_bar.max_value = max_health
	


func _on_Player_hurtBox_Gnoll_hit_player(damage):
	health_bar.value -= damage

func _healthGem_collected():
	health_bar.value += GlobalScript.healthGem_heal

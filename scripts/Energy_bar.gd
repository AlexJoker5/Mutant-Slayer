extends Control

var energy_up = false

func _ready():
	$TextureProgress.max_value = GlobalScript.player_MaxEnergy
	$TextureProgress.value = GlobalScript.player_MaxEnergy
	GlobalScript.player_energy = GlobalScript.player_MaxEnergy
	GlobalScript.connect("dash",self,"_dash_used")
	GlobalScript.connect("playerHit_enemy",self,"playerHit_enemy")
	GlobalScript.connect("Gnollhit_player",self,"GnollHit_player")
	
func _process(delta):
	GlobalScript.player_energy = $TextureProgress.value
	if $TextureProgress.value < $TextureProgress.max_value and !energy_up:
		$Timer.start()
		energy_up = true

func _dash_used(value):
	$TextureProgress.value -= value

func playerHit_enemy(value):
	$TextureProgress.value += 5


func _on_Timer_timeout():
	$TextureProgress.value += 1
	energy_up = false
	$Timer.stop()

func GnollHit_player(value):
	$TextureProgress.value -= 5
	

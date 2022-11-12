extends Control


onready var mana_bar = $Mana_bar
var mana_is_up = false
signal spell1_no_mana(value)
signal spell2_no_mana(value)
signal spell3_no_mana(value)

func _ready():
	mana_bar.max_value = GlobalScript.player_Maxmana
	mana_bar.value = mana_bar.max_value
	GlobalScript.player_mana = mana_bar.max_value
	GlobalScript.connect("spell_1_used",self,"_on_Player_spell1_used")
	GlobalScript.connect("spell_2_used",self,"_on_Player_spell2_used")
	GlobalScript.connect("spell_3_used",self,"_on_Player_spell3_used")
	GlobalScript.connect("manaGem_collected",self,"_manaGem_collected")

func _process(delta):
	GlobalScript.player_mana = mana_bar.value
	$Container/total_mana.text = str(str(mana_bar.value)+"/"+str(mana_bar.max_value))
	if mana_bar.value < mana_bar.max_value and !mana_is_up:
		$Timer.start()
		mana_is_up = true
		
		

	
func _on_mana_updated(mana,amount):
	mana_bar.value = mana
	
	

func _on_max_mana_updated(max_mana):
	mana_bar.max_value = max_mana


func _on_Timer_timeout():
	mana_bar.value += 5
	mana_is_up = false
	$Timer.stop()


func _on_Player_spell1_used():
	mana_bar.value -= GlobalScript.spell1_mana



func _on_Player_spell2_used():
	mana_bar.value -= GlobalScript.spell2_mana


func _on_Player_spell3_used():
	mana_bar.value -= GlobalScript.spell3_mana
	
func _manaGem_collected():
	mana_bar.value += GlobalScript.manaGem_heal

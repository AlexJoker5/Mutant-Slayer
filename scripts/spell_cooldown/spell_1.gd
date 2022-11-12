extends Panel


var cooldown_time = GlobalScript.spell1_cooldown


func _ready():
	$Label.hide()
	$TextureProgress.value = 0
	$Timer.wait_time = cooldown_time
	GlobalScript.connect("spell_1_used",self,"_on_Player_spell1_used")

func _process(delta):
	$Label.text = "%0.1f" % $Timer.time_left
	$TextureProgress.value = int(($Timer.time_left/cooldown_time)*100)
	_change_color()

func _change_color():
	if GlobalScript.player_mana < GlobalScript.spell1_mana:
		$TextureRect.modulate = Color(0.117188, 0.214414, 1)
	if GlobalScript.player_mana >= GlobalScript.spell1_mana:
		$TextureRect.modulate = Color(1, 1, 1)

func _on_Timer_timeout():
	GlobalScript.emit_signal("spell_1_ready")
	$Label.hide()
	$TextureProgress.value = 0



func _on_Player_spell1_used():
	print("spell 1 is used")
	$Label.show()
	$Timer.start()

extends RichTextLabel

var ms = 1
var seconds = 1
export var minutes = 5
var Enemy_count

func _process(delta):
	Enemy_count = GlobalScript.level_win_state-GlobalScript.enemy_death_count
	get_time()

func _on_CountdownTimer_timeout():
	ms -= 1

func get_time():
	if ms == 0:
		ms = 9
		seconds -= 1
	if seconds == 0:
		seconds = 59
		minutes -= 1
		
		
	
	set_text("%02d:%02d:%02d Gnoll-%02d" % [minutes,seconds,ms,Enemy_count])

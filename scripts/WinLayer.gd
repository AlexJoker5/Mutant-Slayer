extends CanvasLayer

onready var buttonLayer = $WinUI/Buttons/ButtonLayer
onready var textLayer = $WinUI/Buttons/TextLayer
var win_count = GlobalScript.level_win_state

func _ready():
	set_visible(false)
	if GlobalScript.level == 1:
		$WinUI/Background/MarginContainer2/Label.text = "You have passed level 1!"
	elif GlobalScript.level == 2:
		$WinUI/Background/MarginContainer2/Label.text = "You have passed level 2!"
	elif GlobalScript.level == 3:
		$WinUI/Background/MarginContainer2/Label.text = "You have passed level 3!"
	

func _process(delta):
	if GlobalScript.enemy_death_count >= win_count:
		if GlobalScript.level == 1:
			GlobalScript.unlock_lvl2 = true
		elif GlobalScript.level == 2:
			GlobalScript.unlock_lvl3 = true
		var data = {
			"unlock_lvl2": GlobalScript.unlock_lvl2,
			"unlock_lvl3": GlobalScript.unlock_lvl3
		}
		var save_file = File.new()
		save_file.open("user://savefile.save", File.WRITE)
		save_file.store_var(data)
		save_file.close()
		_on_Level_1_win_screen()

func set_visible(is_visible : bool):
	for node in get_children():
		node.visible = is_visible
		buttonLayer.visible = is_visible
		textLayer.visible = is_visible
		visible = is_visible


func _on_Level_1_win_screen():
	set_process(false)
	yield(get_tree().create_timer(2),"timeout")
	set_visible(!get_tree().paused)
	get_tree().paused = !get_tree().paused



func _on_MainMenu_pressed():
	$WinUI/AudioStreamPlayer2D.play(0.2)
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/WelcomeMenu.tscn")


func _on_RestartLevel_pressed():
	$WinUI/AudioStreamPlayer2D.play(0.2)
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().paused = !get_tree().paused
	get_tree().reload_current_scene()



func _on_NextLevel_pressed():
	if GlobalScript.level == 1:
		GlobalScript.level = 2
		GlobalScript.level_win_state = 45
		$WinUI/AudioStreamPlayer2D.play(0.2)
		yield(get_tree().create_timer(0.2),"timeout")
		get_tree().change_scene("res://scenes/Level_1.tscn")
	elif GlobalScript.level == 2:
		GlobalScript.level = 3
		GlobalScript.level_win_state = 60
		$WinUI/AudioStreamPlayer2D.play(0.2)
		yield(get_tree().create_timer(0.2),"timeout")
		get_tree().change_scene("res://scenes/Level_1.tscn")
	else:
		pass

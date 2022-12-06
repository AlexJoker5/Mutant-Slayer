extends Control


func _ready():
	var save_file = File.new()
	if not save_file.file_exists("user://savefile.save"):
		return
	save_file.open("user://savefile.save", File.READ)
	var data = save_file.get_var()
	var unlock_lvl2 = data["unlock_lvl2"]
	var unlock_lvl3 = data["unlock_lvl3"]
	if unlock_lvl2 == true:
		$Lvl_2_container.visible = true
	if unlock_lvl3 == true:
		$Lvl_3_container.visible = true

func _physics_process(delta):
	$Lvl_1_container/Lvl1_button/AnimationPlayer.play("glowing_greenDot")
	$Lvl_2_container/Lvl2_button/AnimationPlayer.play("glowing_greenDot")

func _on_Lvl1_button_pressed():
	GlobalScript.level = 1
	GlobalScript.level_win_state = 30
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/Level_1.tscn")


func _on_Back_Button_pressed():
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/WelcomeMenu.tscn")


func _on_Lvl2_button_pressed():
	GlobalScript.level = 2
	GlobalScript.level_win_state = 45
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/Level_1.tscn")


func _on_Lvl3_button_pressed():
	GlobalScript.level = 3
	GlobalScript.level_win_state = 60
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/Level_1.tscn")

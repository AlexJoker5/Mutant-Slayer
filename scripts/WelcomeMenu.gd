extends Control


func _ready():
	pass



func _on_Level_pressed():
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/Level_Menu.tscn")


func _on_exit_pressed():
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().quit()


func _on_gameplay_pressed():
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/Gameplay_menu.tscn")







extends Control


func _ready():
	pass



func _on_back_Button_pressed():
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/WelcomeMenu.tscn")

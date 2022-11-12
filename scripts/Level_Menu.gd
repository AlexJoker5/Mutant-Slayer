extends Control


func _ready():
	pass

func _physics_process(delta):
	$Lvl_1_container/Lvl1_button/AnimationPlayer.play("glowing_greenDot")

func _on_Lvl1_button_pressed():
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/Level_1.tscn")


func _on_Back_Button_pressed():
	$AudioStreamPlayer2D.play(0.2) # Replace with function body.
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/WelcomeMenu.tscn")

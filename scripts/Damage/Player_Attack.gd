extends Area2D

export var Attack_damages = 10

func _ready():
	pass # Replace with function body.


func _on_Player_Attack_area_entered(area):
	if area.is_in_group("Gnoll_Hurtbox"):
		$AudioStreamPlayer2D.play()

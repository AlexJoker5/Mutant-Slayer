extends Area2D


func _ready():
	$CollisionShape2D.disabled = true
	$right_side.visible = false
	$left_side.visible = false
	$Timer.start()

func _process(delta):
	if $AudioStreamPlayer2D.playing == false:
		$AudioStreamPlayer2D.play()
	$CollisionShape2D.disabled = false
	$right_side.visible = true
	$left_side.visible = true


func _on_Timer_timeout():
	$AudioStreamPlayer2D.stop()
	queue_free()

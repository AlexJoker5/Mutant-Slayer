extends Area2D

func _ready():
	$CollisionShape2D.disabled = false

func _on_HealthGem_body_entered(body) -> void:
	print("Before Bounce")
	GlobalScript.emit_signal("healthGem_collected")
	$AnimationPlayer.play("Bounce")
	print("After Bounce")
	set_collision_mask_bit(0,false)
	


func _on_Timer_timeout():
	queue_free()


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

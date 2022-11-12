extends CanvasLayer

onready var buttonLayer = $Pause/Control/ButtonLayer
onready var textLayer = $Pause/Control/TextLayer


func _ready():
	set_visible(false)


func _input(event):
	
	if event.is_action_pressed("pause"):
		$Pause/AudioStreamPlayer2D.play(0.2)
		yield(get_tree().create_timer(0.2),"timeout")
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused
	
func set_visible(is_visible : bool):
	for node in get_children():
		node.visible = is_visible
		buttonLayer.visible = is_visible
		textLayer.visible = is_visible
		visible = is_visible


func _on_Resume_pressed():
	$Pause/AudioStreamPlayer2D.play(0.2)
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().paused = false
	set_visible(false)


func _on_RestartLevel_pressed():
	$Pause/AudioStreamPlayer2D.play(0.2)
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_MainMenu_pressed():
	$Pause/AudioStreamPlayer2D.play(0.2)
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().paused = false
	get_tree().change_scene("res://scenes/WelcomeMenu.tscn")

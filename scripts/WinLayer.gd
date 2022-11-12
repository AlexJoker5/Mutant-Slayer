extends CanvasLayer

onready var buttonLayer = $WinUI/Control/ButtonLayer
onready var textLayer = $WinUI/Control/TextLayer

func _ready():
	set_visible(false)

func _process(delta):
	if GlobalScript.enemy_death_count >= 10:
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
	pass

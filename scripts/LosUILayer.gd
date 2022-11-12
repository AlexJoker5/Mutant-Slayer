extends CanvasLayer

onready var buttonLayer = $LoseUI/Control/ButtonLayer
onready var textLayer = $LoseUI/Control/TextLayer

func _ready():
	set_visible(false)

func _process(delta):
	if GlobalScript.player_health <= 0:
		_on_Player_LoseUI()

func set_visible(is_visible : bool):
	for node in get_children():
		node.visible = is_visible
		buttonLayer.visible = is_visible
		textLayer.visible = is_visible
		visible = is_visible


func _on_Player_LoseUI():
	set_process(false)
	yield(get_tree().create_timer(3),"timeout")
	set_visible(!get_tree().paused)
	get_tree().paused = !get_tree().paused



func _on_MainMenu_pressed():
	$LoseUI/AudioStreamPlayer2D.play(0.2)
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/WelcomeMenu.tscn")


func _on_LevelMenu_pressed():
	$LoseUI/AudioStreamPlayer2D.play(0.2)
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().change_scene("res://scenes/Level_Menu.tscn")


func _on_RestartLevel_pressed():
	$LoseUI/AudioStreamPlayer2D.play(0.2)
	yield(get_tree().create_timer(0.2),"timeout")
	get_tree().paused = !get_tree().paused
	get_tree().reload_current_scene()

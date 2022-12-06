extends Node2D

signal win_screen
signal lose_screen

var zoom_off = true

var wave1 = false
var wave2 = false
var wave3 = false

var score = GlobalScript.score

onready var scoreLabel = $WinLayer/WinUI/Score/MarginContainer/Label
onready var currentTimeLayer = $WinLayer/WinUI/Score/MarginContainer2/Label
onready var countdown = $CountdownLayer/Countdown


onready var ms = countdown.ms
onready var minutes = countdown.minutes
onready var seconds = countdown.seconds

func _ready():
	get_tree().paused = false
	GlobalScript.enemy_death_count = 0
	$Player/Camera2D.zoom.x = 0.2
	$Player/Camera2D.zoom.y = 0.2
	zoom_off = true
	$enemy/Gnoll7.set_physics_process(false)
	$enemy/Gnoll8.set_physics_process(false)
	$enemy/Gnoll9.set_physics_process(false)
	$enemy/Gnoll10.set_physics_process(false)
	$enemy/Gnoll11.set_physics_process(false)
	$enemy/Gnoll12.set_physics_process(false)
	$enemy/Gnoll13.set_physics_process(false)
	$enemy/Gnoll14.set_physics_process(false)
	$enemy/Gnoll15.set_physics_process(false)
	$enemy/Gnoll16.set_physics_process(false)
	$enemy/Gnoll17.set_physics_process(false)
	$enemy/Gnoll18.set_physics_process(false)
	$enemy/Gnoll19.set_physics_process(false)
	$enemy/Gnoll20.set_physics_process(false)
	$enemy/Gnoll21.set_physics_process(false)
	$enemy/Gnoll22.set_physics_process(false)
	$enemy/Gnoll23.set_physics_process(false)
	$enemy/Gnoll24.set_physics_process(false)
	$enemy/Gnoll25.set_physics_process(false)
	$enemy/Gnoll26.set_physics_process(false)
	$enemy/Gnoll27.set_physics_process(false)
	$enemy/Gnoll28.set_physics_process(false)
	$enemy/Gnoll29.set_physics_process(false)
	$enemy/Gnoll30.set_physics_process(false)
	$enemy/Gnoll_blue.set_physics_process(false)
	$enemy/Gnoll_blue2.set_physics_process(false)
	$enemy/Gnoll_blue3.set_physics_process(false)
	$enemy/Gnoll_blue4.set_physics_process(false)
	$enemy/Gnoll_blue5.set_physics_process(false)
	$enemy/Gnoll_blue6.set_physics_process(false)
	$enemy/Gnoll_blue7.set_physics_process(false)
	$enemy/Gnoll_blue8.set_physics_process(false)
	$enemy/Gnoll_blue9.set_physics_process(false)
	$enemy/Gnoll_blue10.set_physics_process(false)
	$enemy/Gnoll_blue11.set_physics_process(false)
	$enemy/Gnoll_blue12.set_physics_process(false)
	$enemy/Gnoll_blue13.set_physics_process(false)
	$enemy/Gnoll_blue14.set_physics_process(false)
	$enemy/Gnoll_blue15.set_physics_process(false)
	$enemy/Gnoll_red.set_physics_process(false)
	$enemy/Gnoll_red2.set_physics_process(false)
	$enemy/Gnoll_red3.set_physics_process(false)
	$enemy/Gnoll_red4.set_physics_process(false)
	$enemy/Gnoll_red5.set_physics_process(false)
	$enemy/Gnoll_red6.set_physics_process(false)
	$enemy/Gnoll_red7.set_physics_process(false)
	$enemy/Gnoll_red8.set_physics_process(false)
	$enemy/Gnoll_red9.set_physics_process(false)
	$enemy/Gnoll_red10.set_physics_process(false)
	$enemy/Gnoll_red11.set_physics_process(false)
	$enemy/Gnoll_red12.set_physics_process(false)
	$enemy/Gnoll_red13.set_physics_process(false)
	$enemy/Gnoll_red14.set_physics_process(false)
	$enemy/Gnoll_red15.set_physics_process(false)
	
func _process(delta):
	#print("Before score" + str(score))
	score = GlobalScript.enemy_death_count * 25
	#countdown.minutes = 8
	#print(GlobalScript.enemy_death_count)
	if(countdown.minutes < 1 and countdown.seconds >0):
		score += 100
		countdown.modulate = Color.red
		#print("After score(1min)" + str(score))
	elif(countdown.minutes < 2):
		score += 200
		#print("After score(2min)" + str(score))
	elif(countdown.minutes < 3):
		score += 300
		#print("After score(3min)" + str(score))
	elif(countdown.minutes < 4):
		score += 400
		#print("After score(4min)" + str(score))
	elif(countdown.minutes < 5):
		score += 500
		#print("After score(5min)" + str(score))
	scoreLabel.text = "Score - " + str(score)
	if ms == 0:
		ms = 9
		seconds -= 1
	if seconds == 0:
		seconds = 59
		minutes -= 1
	if minutes <0: 
		game_over();
	currentTimeLayer.set_text("Time - " + ("%02d:%02d:%02d" % [minutes,seconds,ms]))
	if zoom_off:
		yield(get_tree().create_timer(1),"timeout")
		zoom_off = false
	if $Player/Camera2D.zoom.x < 0.5 and $Player/Camera2D.zoom.y <= 0.5:
		$Player/Camera2D.zoom.x += 0.01
		$Player/Camera2D.zoom.y += 0.01
	print(GlobalScript.level)
	
	if GlobalScript.level == 1:
		level_one()
	elif GlobalScript.level == 2:
		level_two()
	elif GlobalScript.level == 3:
		level_three()
	
func win_game():
	emit_signal("win_screen")

func game_over():
	emit_signal("lose_screen")

func _on_CountdownTimer_timeout():
	ms -= 1

func level_one():
	if GlobalScript.enemy_death_count >= 3 and !wave1:
		$enemy/Gnoll7.set_physics_process(true)
		$enemy/Gnoll8.set_physics_process(true)
		$enemy/Gnoll9.set_physics_process(true)
		$enemy/Gnoll10.set_physics_process(true)
		$enemy/Gnoll11.set_physics_process(true)
		$enemy/Gnoll12.set_physics_process(true)
		$enemy/Gnoll13.set_physics_process(true)
		$enemy/Gnoll14.set_physics_process(true)
		$enemy/Gnoll15.set_physics_process(true)
		$enemy/Gnoll16.set_physics_process(true)
		wave1 = true
	
	if GlobalScript.enemy_death_count >= 10 and !wave2:
		
		$enemy/Gnoll17.set_physics_process(true)
		$enemy/Gnoll18.set_physics_process(true)
		$enemy/Gnoll19.set_physics_process(true)
		$enemy/Gnoll20.set_physics_process(true)
		$enemy/Gnoll21.set_physics_process(true)
		$enemy/Gnoll22.set_physics_process(true)
		$enemy/Gnoll23.set_physics_process(true)
		$enemy/Gnoll24.set_physics_process(true)
		$enemy/Gnoll25.set_physics_process(true)
		$enemy/Gnoll26.set_physics_process(true)
		wave2 = true
	
	if GlobalScript.enemy_death_count >= 18 and !wave3:
		$enemy/Gnoll27.set_physics_process(true)
		$enemy/Gnoll28.set_physics_process(true)
		$enemy/Gnoll29.set_physics_process(true)
		$enemy/Gnoll30.set_physics_process(true)
		wave3 = true

func level_two():
	if GlobalScript.enemy_death_count >= 3 and !wave1:
		$enemy/Gnoll7.set_physics_process(true)
		$enemy/Gnoll8.set_physics_process(true)
		$enemy/Gnoll9.set_physics_process(true)
		$enemy/Gnoll10.set_physics_process(true)
		$enemy/Gnoll11.set_physics_process(true)
		$enemy/Gnoll12.set_physics_process(true)
		$enemy/Gnoll13.set_physics_process(true)
		$enemy/Gnoll14.set_physics_process(true)
		$enemy/Gnoll15.set_physics_process(true)
		$enemy/Gnoll16.set_physics_process(true)
		$enemy/Gnoll_blue.set_physics_process(true)
		$enemy/Gnoll_blue2.set_physics_process(true)
		$enemy/Gnoll_blue6.set_physics_process(true)
		$enemy/Gnoll_blue11.set_physics_process(true)
		$enemy/Gnoll_blue12.set_physics_process(true)
		wave1 = true
	if GlobalScript.enemy_death_count >= 10 and !wave2:
		$enemy/Gnoll17.set_physics_process(true)
		$enemy/Gnoll18.set_physics_process(true)
		$enemy/Gnoll19.set_physics_process(true)
		$enemy/Gnoll20.set_physics_process(true)
		$enemy/Gnoll21.set_physics_process(true)
		$enemy/Gnoll22.set_physics_process(true)
		$enemy/Gnoll23.set_physics_process(true)
		$enemy/Gnoll24.set_physics_process(true)
		$enemy/Gnoll25.set_physics_process(true)
		$enemy/Gnoll26.set_physics_process(true)
		$enemy/Gnoll_blue3.set_physics_process(true)
		$enemy/Gnoll_blue7.set_physics_process(true)
		$enemy/Gnoll_blue8.set_physics_process(true)
		$enemy/Gnoll_blue13.set_physics_process(true)
		wave2 = true
	if GlobalScript.enemy_death_count >= 18 and !wave3:
		$enemy/Gnoll27.set_physics_process(true)
		$enemy/Gnoll28.set_physics_process(true)
		$enemy/Gnoll29.set_physics_process(true)
		$enemy/Gnoll30.set_physics_process(true)
		$enemy/Gnoll_blue4.set_physics_process(true)
		$enemy/Gnoll_blue5.set_physics_process(true)
		$enemy/Gnoll_blue9.set_physics_process(true)
		$enemy/Gnoll_blue10.set_physics_process(true)
		$enemy/Gnoll_blue14.set_physics_process(true)
		$enemy/Gnoll_blue15.set_physics_process(true)
		wave3 = true
	
func level_three():
	if GlobalScript.enemy_death_count >= 3 and !wave1:
		$enemy/Gnoll7.set_physics_process(true)
		$enemy/Gnoll8.set_physics_process(true)
		$enemy/Gnoll9.set_physics_process(true)
		$enemy/Gnoll10.set_physics_process(true)
		$enemy/Gnoll11.set_physics_process(true)
		$enemy/Gnoll12.set_physics_process(true)
		$enemy/Gnoll13.set_physics_process(true)
		$enemy/Gnoll14.set_physics_process(true)
		$enemy/Gnoll15.set_physics_process(true)
		$enemy/Gnoll16.set_physics_process(true)
		$enemy/Gnoll_blue.set_physics_process(true)
		$enemy/Gnoll_blue2.set_physics_process(true)
		$enemy/Gnoll_blue6.set_physics_process(true)
		$enemy/Gnoll_blue11.set_physics_process(true)
		$enemy/Gnoll_blue12.set_physics_process(true)
		$enemy/Gnoll_red.set_physics_process(true)
		$enemy/Gnoll_red2.set_physics_process(true)
		$enemy/Gnoll_red6.set_physics_process(true)
		$enemy/Gnoll_red11.set_physics_process(true)
		$enemy/Gnoll_red12.set_physics_process(true)
		wave1 = true
	if GlobalScript.enemy_death_count >= 10 and !wave2:
		$enemy/Gnoll17.set_physics_process(true)
		$enemy/Gnoll18.set_physics_process(true)
		$enemy/Gnoll19.set_physics_process(true)
		$enemy/Gnoll20.set_physics_process(true)
		$enemy/Gnoll21.set_physics_process(true)
		$enemy/Gnoll22.set_physics_process(true)
		$enemy/Gnoll23.set_physics_process(true)
		$enemy/Gnoll24.set_physics_process(true)
		$enemy/Gnoll25.set_physics_process(true)
		$enemy/Gnoll26.set_physics_process(true)
		$enemy/Gnoll_blue3.set_physics_process(true)
		$enemy/Gnoll_blue7.set_physics_process(true)
		$enemy/Gnoll_blue8.set_physics_process(true)
		$enemy/Gnoll_blue13.set_physics_process(true)
		$enemy/Gnoll_red3.set_physics_process(true)
		$enemy/Gnoll_red7.set_physics_process(true)
		$enemy/Gnoll_red8.set_physics_process(true)
		$enemy/Gnoll_red13.set_physics_process(true)
		wave2 = true
	if GlobalScript.enemy_death_count >= 18 and !wave3:
		$enemy/Gnoll27.set_physics_process(true)
		$enemy/Gnoll28.set_physics_process(true)
		$enemy/Gnoll29.set_physics_process(true)
		$enemy/Gnoll30.set_physics_process(true)
		$enemy/Gnoll_blue4.set_physics_process(true)
		$enemy/Gnoll_blue5.set_physics_process(true)
		$enemy/Gnoll_blue9.set_physics_process(true)
		$enemy/Gnoll_blue10.set_physics_process(true)
		$enemy/Gnoll_blue14.set_physics_process(true)
		$enemy/Gnoll_blue15.set_physics_process(true)
		$enemy/Gnoll_red4.set_physics_process(true)
		$enemy/Gnoll_red5.set_physics_process(true)
		$enemy/Gnoll_red9.set_physics_process(true)
		$enemy/Gnoll_red10.set_physics_process(true)
		$enemy/Gnoll_red14.set_physics_process(true)
		$enemy/Gnoll_red15.set_physics_process(true)
		wave3 = true

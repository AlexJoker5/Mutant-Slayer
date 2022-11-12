extends Node2D

signal win_screen

var zoom_off = true

var wave1 = false
var wave2 = false
var wave3 = false

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
	
func _process(delta):
	if zoom_off:
		yield(get_tree().create_timer(1),"timeout")
		zoom_off = false
	if $Player/Camera2D.zoom.x < 0.5 and $Player/Camera2D.zoom.y <= 0.5:
		$Player/Camera2D.zoom.x += 0.01
		$Player/Camera2D.zoom.y += 0.01
	
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
		wave3 = true
	
func win_game():
	emit_signal("win_screen")

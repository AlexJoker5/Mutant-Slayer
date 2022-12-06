extends KinematicBody2D

var speed : int = GlobalScript.player_speed
var acceleration = 1000
var friction = 2500
var dash_vector = Vector2.RIGHT
var dash_speed = 220
var attack_mv_vector = Vector2.RIGHT
var attack_mv_speed = 10
var attack_combo = 3
var attack_combo_reset = false
var flip = false
var spell1_going = false
var spell1_On_cd = false
var spell2_On_cd = false
var spell3_On_cd = false
var spell1_enough_mana = true
var spell2_enough_mana = true
var spell3_enough_mana = true

enum{
	MOVE,
	ATTACK1,
	ATTACK2,
	ATTACK3,
	DASH,
	SPELL1_CAST,
	SPELL2_CAST,
	SPELL3_CAST,
	HURT,
	DEATH
}

var state = MOVE
var velocity : Vector2 = Vector2.ZERO
onready var animationState = $AnimationTree.get("parameters/playback")
onready var spell_3 = preload("res://scenes/spell_3.tscn")


func _ready():
	
	$Player_Attack/attack_collision.disabled = true
	$spell_1.visible = false
	$spell_2.visible = false
	GlobalScript.connect("spell_1_ready",self,"_on_spell_1_spell1_ready")
	GlobalScript.connect("spell_2_ready",self,"_on_spell_2_spell2_ready")
	GlobalScript.connect("spell_3_ready",self,"_on_spell_3_spell3_ready")

func _physics_process(delta):
	GlobalScript.Player_pos = position
	match state:
		MOVE:
			move_state(delta)
		ATTACK1:
			attack1_state(delta)
		ATTACK2:
			attack2_state(delta)
		ATTACK3:
			attack3_state(delta)
		DASH:
			dash_state(delta)
		SPELL1_CAST:
			spell1_cast_state(delta)
		SPELL2_CAST:
			spell2_cast_state(delta)
		SPELL3_CAST:
			spell3_cast_state(delta)
		HURT:
			hurt_state(delta)
		DEATH:
			death_state(delta)
var d = null
func move_state(delta):
	#player movement 
	d = delta
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	if input_vector.x > 0 and flip:
		scale.x *= -1
		flip = false
	elif input_vector.x < 0 and !flip:
		scale.x *= -1
		flip = true
	
	if input_vector != Vector2.ZERO:
		dash_vector = input_vector
		attack_mv_vector = input_vector
		$AnimationPlayer.set("parameters/Idle/blend_position", input_vector)
		$AnimationPlayer.set("parameters/walk/blend_position", input_vector)
		$AnimationPlayer.set("parameters/attack1/blend_position", input_vector)
		$AnimationPlayer.set("parameters/attack1.1/blend_position", input_vector)
		$AnimationPlayer.set("parameters/attack1.2/blend_position", input_vector)
		$AnimationPlayer.set("parameters/dash/blend_position", input_vector)
		$AnimationPlayer.set("parameters/spell_cast/blend_position", input_vector)
		$AnimationPlayer.set("parameters/player_death/blend_position", input_vector)
		$AnimationPlayer.set("parameters/hurt/blend_position", input_vector)
		
		animationState.travel("walk")
		
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		animationState.travel("Idle")
		
	move()
	
	if Input.is_action_just_pressed("attack_1"):
		$Attack_sound.play()
		state = ATTACK1
	elif Input.is_action_just_pressed("attack_2"):
		$Attack_Idl_sound.play()
		$Attack_sound.play()
		state = ATTACK2
	elif Input.is_action_just_pressed("attack_3"):
		$Attack_Idl_sound.play()
		$Attack_sound.play()
		state = ATTACK3
	if Input.is_action_just_pressed("spell1_cast") and !spell1_On_cd:
		if GlobalScript.player_mana >= GlobalScript.spell1_mana:
			spell1_going = true
			state = SPELL1_CAST
			spell1_On_cd = true
			GlobalScript.emit_signal("spell_1_used")
		else:
			print("not enough mana 1")
	elif Input.is_action_just_pressed("spell3_cast") and !spell3_On_cd:
		if  GlobalScript.player_mana >= GlobalScript.spell3_mana:
			state = SPELL2_CAST
			spell3_On_cd = true
			GlobalScript.emit_signal("spell_3_used")
		else:
			print("not enough mana 3")
	elif Input.is_action_just_pressed("spell2_cast") and !spell2_On_cd:
		if GlobalScript.player_mana >= GlobalScript.spell2_mana:
			state = SPELL3_CAST
			spell2_On_cd = true
			GlobalScript.emit_signal("spell_2_used")
		else:
			print("not enough mana 2")
	
	if Input.is_action_just_pressed("dash"):
		if GlobalScript.player_energy >= 40:
			GlobalScript.emit_signal("dash",GlobalScript.dash_energy)
			state = DASH
		else:
			state = MOVE
		
	if GlobalScript.player_health <= 0:
		state = DEATH
	

func move():
	velocity = move_and_slide(velocity)
	
#Attack_1 function
func attack1_state(delta):
	velocity = attack_mv_vector * attack_mv_speed
	move()
	if attack_combo == 3:
		$AttackResetTimer.start()
		animationState.travel("attack1")
	if attack_combo == 2 and Input.is_action_just_pressed("attack_1"):
		$AttackResetTimer.start()
		$Attack_sound.play()
		
		animationState.travel("attack1.1")
	elif attack_combo == 1 and Input.is_action_just_pressed("attack_1"):
		$AttackResetTimer.start()
		$Attack_sound.play()
		
		animationState.travel("attack1.2")

func attack_sound():
	$Attack_Idl_sound.play()

func attack1_animation_finished():
	if attack_combo_reset:
		attack_combo = 3
		state = MOVE
		attack_combo_reset = false
	else:
		attack_combo = 2

func attack1_1_animation_finished():
	if attack_combo_reset:
		attack_combo = 3
		state = MOVE
		attack_combo_reset = false
	else:
		attack_combo = 1
	
func attack1_2_animation_finished():
	state = MOVE
	attack_combo = 3
	$AttackResetTimer.stop()

#Attack_2 function
func attack2_state(delta):
	velocity = Vector2.ZERO

	animationState.travel("attack2")

func attack2_animation_finished():
	state = MOVE

#Attack_3 function
func attack3_state(delta):
	velocity = attack_mv_vector * 80
	move()
	animationState.travel("attack3")
func attack3_animation_finished():
	state = MOVE

#spell cast

func spell1_cast_state(delta):
	velocity = Vector2.ZERO
	move()
	if $spell_1/AudioStreamPlayer2D.playing == false:
		$spell_1/AudioStreamPlayer2D.play()
	animationState.travel("spell_cast")
	if Input.is_action_pressed("ui_up"):
		if spell1_going:
			$spell_1/AnimationPlayer.play("spell_1_firebird_up")
			spell1_going = false
	elif Input.is_action_pressed("ui_down"):
		if spell1_going:
			$spell_1/AnimationPlayer.play("spell_1_firebird_down")
			spell1_going = false
	else:
		if spell1_going:
			$spell_1/AnimationPlayer.play("spell_1_firebird")
			spell1_going = false

func spell2_cast_state(delta):
	velocity = Vector2.ZERO
	move()
	if $spell_2/AudioStreamPlayer2D.playing == false:
		$spell_2/AudioStreamPlayer2D.play(1)
	animationState.travel("spell2_cast")
	$spell_2/AnimationPlayer.play("spell_2_explosion")

var fire_create = true
var fire_count = 0
func spell3_cast_state(delta):
	move_state(delta)
	if fire_create and fire_count <= 4:
		var spell3_instance = spell_3.instance()
		spell3_instance.position = global_position
		get_parent().add_child(spell3_instance)
		fire_create = false
		yield(get_tree().create_timer(1),"timeout")
		fire_count += 1
		fire_create = true
	if fire_count > 0:
		state = MOVE
		fire_count = 0
	
func _on_spell_3timer_timeout():
	$spell_3timer.stop()
	$spell_3.visible = false
	$spell_3/CollisionShape2D.disabled = true
	spellCast_animation_finished()
	
	
func spellCast_animation_finished():
	if $spell_1/AudioStreamPlayer2D.get_playback_position() >=1:
		$spell_1/AudioStreamPlayer2D.stop()
	if $spell_2/AudioStreamPlayer2D.get_playback_position() >= 3:
		$spell_2/AudioStreamPlayer2D.stop()
	state = MOVE

#Dash function
func dash_state(delta):
	velocity = dash_vector * dash_speed
	move()
	animationState.travel("dash")

func dash_animation_finished():
	state = MOVE


func _on_Timer_timeout():
	state = MOVE
	attack_combo = 3
	attack_combo_reset = true
	$AttackResetTimer.stop()

func _on_spell_1_spell1_ready():
	spell1_On_cd = false
	print("spell 1 ready")

func _on_spell_2_spell2_ready():
	spell2_On_cd = false
	print("spell 2 ready")


func _on_spell_3_spell3_ready():
	spell3_On_cd = false
	print("spell 3 ready")


func hurt_state(delta):
	$Player_hurt.play()
	animationState.travel("hurt")
	state = MOVE



func death_state(delta):
	velocity = Vector2.ZERO
	move()
	$Player_hurtBox/CollisionShape2D.disabled = true
	$CollisionShape2D2.disabled = true
	animationState.travel("player_death")

func on_player_death():
	$AnimationTree.active = false




func _on_Player_hurtBox_Gnoll_knock_player():
	state = HURT
	if position.x > GlobalScript.Gnoll_pos.x:
		print("left")
		velocity.x += 200
	elif position.x < GlobalScript.Gnoll_pos.x:
		print("rght")
		velocity.x -= 200


func _on_Player_hurtBox_GnollBlue_slow(value):
	speed = value
	$AnimatedSprite.modulate = Color(0.270588, 0.482353, 0.886275)
	$Player_slowed.start()


func _on_Player_slowed_timeout():
	speed = GlobalScript.player_speed
	$AnimatedSprite.modulate = Color(1,1,1)
	$Player_slowed.stop()

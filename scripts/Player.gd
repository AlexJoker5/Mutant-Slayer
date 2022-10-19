extends KinematicBody2D

var speed : int = 150
var acceleration = 1000
var friction = 2500
var dash_vector = Vector2.RIGHT
var dash_speed = 220
var attack_mv_vector = Vector2.RIGHT
var attack_mv_speed = 10
var attack_combo = 3
var flip = false
var stats = PlayerStats

enum{
	MOVE,
	ATTACK1,
	ATTACK2,
	ATTACK3,
	DASH,
	SPELL1_CAST,
	SPELL2_CAST
}
var state = MOVE
var velocity : Vector2 = Vector2.ZERO

onready var animationState = $AnimationTree.get("parameters/playback")
onready var hurtBox = $Hurtbox


func _ready():
	$Attack/attack_collision.disabled = true
	$spell_1.visible = false
	$spell_2.visible = false
	stats.connect("no_health",self, "queue_free")

func _physics_process(delta):
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
	
func move_state(delta):
	#player movement 
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
		
		animationState.travel("walk")
		
		velocity = velocity.move_toward(input_vector * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		animationState.travel("Idle")
		
	move()
	
	if Input.is_action_just_pressed("attack_1"):
		state = ATTACK1
	elif Input.is_action_just_pressed("attack_2"):
		state = ATTACK2
	elif Input.is_action_just_pressed("attack_3"):
		state = ATTACK3
	if Input.is_action_just_pressed("spell1_cast"):
		state = SPELL1_CAST
	elif Input.is_action_just_pressed("spell2_cast"):
		state = SPELL2_CAST
	
	if Input.is_action_just_pressed("dash"):
		state = DASH
	

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
		animationState.travel("attack1.1")
	elif attack_combo == 1 and Input.is_action_just_pressed("attack_1"):
		$AttackResetTimer.start()
		animationState.travel("attack1.2")
		
func attack1_animation_finished():
	attack_combo = 2

func attack1_1_animation_finished():
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
	animationState.travel("spell_cast")
	$spell_1/AnimationPlayer.play("spell_1_firebird")

func spell2_cast_state(delta):
	velocity = Vector2.ZERO
	move()
	animationState.travel("spell2_cast")
	$spell_2/AnimationPlayer.play("spell_2_explosion")
	
func spellCast_animation_finished():
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
	$AttackResetTimer.stop()
	
func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	hurtBox.start_invincibility(0.5)
	hurtBox.create_hit_effect()

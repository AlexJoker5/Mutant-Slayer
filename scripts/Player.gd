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
enum{
	MOVE,
	ATTACK1,
	ATTACK2,
	ATTACK3,
	DASH,
	SPELL_CAST
}
var state = MOVE
var velocity : Vector2 = Vector2.ZERO
onready var animationState = $AnimationTree.get("parameters/playback")

func _ready():
	$Attack/attack_collision.disabled = true

func _physics_process(delta):
	print(velocity)
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
		SPELL_CAST:
			spell_cast_state(delta)
	
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
	if Input.is_action_just_pressed("spell_cast"):
		state = SPELL_CAST
	
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

	elif attack_combo == 2 and Input.is_action_just_pressed("attack_1"):
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
func spell_cast_state(delta):
	velocity = Vector2.ZERO
	move()
	animationState.travel("spell_cast")

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



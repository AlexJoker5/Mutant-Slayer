extends KinematicBody2D

const GnottDeathEffect = preload("res://scenes/Effects/GnottDeathEffect.tscn")
var gem_randomizer : RandomNumberGenerator = RandomNumberGenerator.new()
onready var healthGem = preload("res://scenes/Gems/HealthGem.tscn")
onready var manaGem = preload("res://scenes/Gems/ManaGem.tscn")


export var ACCELARATION = 120
export var WALK_SPEED = 70
export var FRICTION = 120
export var ATTACK_DISTANCE = 20
var is_flip = false

signal hit_by_spell2 
signal hit_by_attack(value)
signal hit_by_spell1
signal hit_by_spell3

enum {
	IDLE,
	CHASE,
	ATTACK,
	HURT,
	DEATH
}

var velocity = Vector2.ZERO

var knockback = Vector2.ZERO

var state = CHASE

var gnoll_flip = false

onready var sprite = $AnimatedSprite
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtBox = $Hurtbox
onready var softCollision = $SoftCollision
onready var player = get_node(@"/root/Level_1/Player")
onready var animationPlayer = $AnimationPlayer

	
func _physics_process(delta):
	GlobalScript.Gnoll_pos = position
	match state:
		IDLE:
			if position.x < GlobalScript.Player_pos.x and !is_flip:
				$Hitbox.scale.x *= -1
				$Hurtbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = true
			elif position.x > GlobalScript.Player_pos.x and is_flip:
				$Hitbox.scale.x *= -1
				$Hurtbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = false
			animationPlayer.play("Idle")
			
		CHASE:
			if $Gnoll_scream.playing == false:
				$Gnoll_scream.play()
				
			if position.x < GlobalScript.Player_pos.x and !is_flip:
				$Hitbox.scale.x *= -1
				$Hurtbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = true
			elif position.x > GlobalScript.Player_pos.x and is_flip:
				$Hitbox.scale.x *= -1
				$Hurtbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = false
			if GlobalScript.player_health > 0:
				var direction = (GlobalScript.Player_pos - position).normalized()
				velocity = velocity.move_toward(direction * WALK_SPEED, ACCELARATION *delta)
				animationPlayer.play("Walk")
				#sprite.flip_h = velocity.x < 0
				
				seek_player()
			elif GlobalScript.player_health <= 0:
				print("we win")
				enemy_Celebrated()
		ATTACK:
			$Gnoll_scream.stop()
			if position.x < GlobalScript.Player_pos.x and is_flip:
				$Hitbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = false
			elif position.x > GlobalScript.Player_pos.x and !is_flip:
				$Hitbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = true
			var player = playerDetectionZone.player
			if player != null and GlobalScript.player_health > 0:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction, ATTACK_DISTANCE)
				
				animationPlayer.play("Attack")
				
				#yield(animationPlayer,"animation_finished")
				
			elif player == null and GlobalScript.player_health > 0:
				state = CHASE
				state = CHASE
			elif GlobalScript.player_health <= 0:
				print("we win")
				enemy_Celebrated()
		HURT:
			$Gnoll_scream.stop()
			if position.x < GlobalScript.Player_pos.x and !is_flip:
				$Hitbox.scale.x *= -1
				$Hurtbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = true
			elif position.x > GlobalScript.Player_pos.x and is_flip:
				$Hitbox.scale.x *= -1
				$Hurtbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = false
			animationPlayer.play("Hurt")
		
		DEATH:
			$Gnoll_scream.stop()
			$Hurtbox/CollisionShape2D.disabled = true
			$SoftCollision/CollisionShape2D.disabled = true
			$EnemyHealthBar.visible = false
			if position.x < GlobalScript.Player_pos.x and !is_flip:
				$Hitbox.scale.x *= -1
				$Hurtbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = true
			elif position.x > GlobalScript.Player_pos.x and is_flip:
				$Hitbox.scale.x *= -1
				$Hurtbox.scale.x *= -1
				sprite.scale.x *= -1
				is_flip = false
			$Gnoll_scream.playing = false
			animationPlayer.play("Death")
				
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 200
	velocity = move_and_slide(velocity)
	

func seek_player():
	if playerDetectionZone.can_seek_player():
		state = ATTACK

func gem_generator():
	gem_randomizer.randomize()
	var drop_percent:int = gem_randomizer.randi_range(1,100)
	return drop_percent


func _on_EnemyHealthBar_no_health():
	velocity = move_and_slide(Vector2.ZERO)
	state = DEATH

		
func enemy_Celebrated():
	state = IDLE
	velocity = Vector2.ZERO
	$EnemyHealthBar.visible = false






func _on_Hurtbox_player_knock_Gnoll(knock_value):
	$Gnoll_scream.playing = true
	state = HURT
	print("haa")
	if position.x > GlobalScript.Player_pos.x:
		velocity.x += knock_value
	elif position.x < GlobalScript.Player_pos.x:
		velocity.x -= knock_value
		
func _hurt_animation_finished():
	$Gnoll_scream.playing = false
	state = CHASE

func _on_death_animation_finished():
	queue_free()
	GlobalScript.enemy_death_count += 1
	var gem_type = gem_generator()
	if gem_type <= 20:
		var healthGem_instance = healthGem.instance()
		healthGem_instance.position = global_position
		get_parent().add_child(healthGem_instance)
	elif gem_type <= 60:
		var manaGem_instance = manaGem.instance()
		manaGem_instance.position = global_position
		get_parent().add_child(manaGem_instance)
	else:
		pass



func _on_Gnoll_scream_finished():
	$Gnoll_scream.stop()
	$Gnoll_scream/Timer.start()
	$Gnoll_scream.playing = true
	print("stop")


func _on_Gnoll_scream_Timer_timeout():
	$Gnoll_scream.playing = false
	print("time_stop")


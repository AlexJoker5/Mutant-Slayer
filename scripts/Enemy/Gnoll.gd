extends KinematicBody2D

const GnottDeathEffect = preload("res://scenes/Effects/GnottDeathEffect.tscn")

export var ACCELARATION = 250 
export var MAX_SPEED = 40
export var FRICTION = 120

signal hit_by_spell2 

enum {
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO

var knockback = Vector2.ZERO

var state = CHASE

var gnoll_flip = false

onready var sprite = $AnimatedSprite
onready var shadowSprite = $ShadowSprite
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var hurtBox = $Hurtbox
onready var softCollision = $SoftCollision

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
		WANDER:
			pass
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELARATION * delta)
			if !gnoll_flip and velocity.x > 0:
				scale.x *= -1
				gnoll_flip = false
			elif gnoll_flip and velocity.x < 0:
				scale.x *= -1
				gnoll_flip = true
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 200
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetectionZone.can_seek_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	hurtBox.create_hit_effect()

func _on_Stats_no_health():
	queue_free()
	var gnottDeathEffect = GnottDeathEffect.instance()
	get_parent().add_child(gnottDeathEffect)
	gnottDeathEffect.global_position = global_position
	gnottDeathEffect.global_scale = global_scale

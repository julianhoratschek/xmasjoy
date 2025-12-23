class_name Enemy extends PooledObject

"""
Base class for all enemies
Subclass this for enemies and set health, speed, damage and xp in _ready
"""

## Used to spawn XP when enemy is defeated
static var XPBallPrefab = preload("res://prefabs/xp.tscn")

## Convenience to interact with player
static var player: Player = null


## First Health of the enemy
@export var spawn_health := 100

## First Movement-speed
@export var spawn_speed := 50

## First Damage done on collision with enemy
@export var spawn_damage := 10

## First XP dropped when defeated
@export var spawn_xp := 10

## Direction enemy is walking into
var _direction := Vector2.ZERO

## Sets starting animation if it differs from editor set starting animation
# If changed, should be changed in _ready()
var _starting_animation: StringName

## Effective current health
var health := 0

## Effective current speed
var speed := 0

## Effective current damage dealt
var damage := 0

## Effective current xp
var xp := 0


## Create a XP-instance (called when health is 0)
func create_xp() -> void:
	var new_xp = XPBallPrefab.instantiate()

	$AnimatedSprite2D.animation_finished.disconnect(create_xp)
	new_xp.position = position
	new_xp.amount = xp
	player.add_sibling(new_xp)

	release()


## Death animation resulting in xp-spawn and object release
func death_animation() -> void:
	var animated_sprite := $AnimatedSprite2D as AnimatedSprite2D

	# Don't move during animation
	speed = 0

	# Don't collide during animation
	$Area2D.process_mode = Node.PROCESS_MODE_DISABLED

	animated_sprite.play("death")
	animated_sprite.animation_finished.connect(create_xp,
		ConnectFlags.CONNECT_ONE_SHOT | ConnectFlags.CONNECT_DEFERRED)



## Called when enemy is hit by projectile
func hit_by(projectile: Projectile) -> void:
	if not projectile.piercing:
		projectile.release()

	health -= projectile.get_damage()
	if health <= 0:
		death_animation()
		return
	
	# Pushback enemy
	position -= _direction * projectile.pushback


## Reset base values on respawn from pool
func _on_spawn():
	$AnimatedSprite2D.animation = _starting_animation
	$Area2D.process_mode = Node.PROCESS_MODE_INHERIT
	health = spawn_health
	speed = spawn_speed
	damage = spawn_damage
	xp = spawn_xp


func _ready() -> void:
	_starting_animation = $AnimatedSprite2D.animation


## Simple movement towards player
func _process(delta: float) -> void:
	_direction = position.direction_to(player.position)

	position += _direction * speed * delta

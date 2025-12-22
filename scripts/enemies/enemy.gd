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
	new_xp.position = position
	new_xp.amount = xp
	player.add_sibling(new_xp)


## Called when enemy is hit by projectile
func hit_by(projectile: Projectile) -> void:
	if not projectile.piercing:
		projectile.release()

	health -= projectile.get_damage()
	if health <= 0:
		call_deferred("create_xp")
		release()
		return
	
	# Pushback enemy
	position -= _direction * projectile.pushback


## Reset base values on respawn from pool
func _on_spawn():
	health = spawn_health
	speed = spawn_speed
	damage = spawn_damage
	xp = spawn_xp


## Simple movement towards player
func _process(delta: float) -> void:
	_direction = position.direction_to(player.position)

	position += _direction * speed * delta

class_name Enemy extends Node2D

"""
Base class for all enemies
"""

## Used to spawn XP when enemy is defeated
static var XPBallPrefab = preload("res://prefabs/xp.tscn")

## Convenience to interact with player
static var player: Player = null


## Health of the enemy
var health := 100

## Movement-speed
var speed := 50

## Damage done on collision with enemy
var damage := 10

## XP dropped when defeated
var xp := 10


## Create a XP-instance (called when health is 0)
func create_xp() -> void:
	var new_xp = XPBallPrefab.instantiate()
	new_xp.position = position
	new_xp.amount = xp
	player.add_sibling(new_xp)


## Called when enemy is hit by projectile
func hit_by(projectile: Projectile) -> void:
	if not projectile.piercing:
		projectile.queue_free()

	health -= projectile.damage
	if health <= 0:
		call_deferred("create_xp")
		queue_free()
		return
	
	# Pushback enemy
	var dir := position.direction_to(player.position)
	position -= dir * projectile.pushback


## Simple movement towards player
func _process(delta: float) -> void:
	var dir := position.direction_to(player.position)

	position += dir * speed * delta

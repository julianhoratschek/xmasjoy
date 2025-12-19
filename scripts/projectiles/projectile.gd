class_name Projectile extends Node2D


"""
Base class for all projectiles
"""


## Flying speed of projectile
var speed := 400

## Damage done when projectile hits enemy
var damage := 25

## Direction the projectile is travelling in
var direction := Vector2.UP

## True is projectile won't despawn when an enemy was hit
var piercing := false

## How much an enemy is pushed back on hit
var pushback := 20.0

## How long this projectile will persist
var _lifetime := 3.0


## Simple movement and lifetime checker
func _process(delta: float) -> void:
	position += speed * delta * direction

	_lifetime -= delta
	if _lifetime < 0.0:
		queue_free()


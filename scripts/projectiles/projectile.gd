class_name Projectile extends PooledObject


"""
Base class for all projectiles
"""


## Flying speed of projectile
@export var speed := 400

## Damage done when projectile hits enemy
@export var damage := 25

## True is projectile won't despawn when an enemy was hit
@export var piercing := false

## How much an enemy is pushed back on hit
@export var pushback := 10.0

## How long until this object is released
@export var lifetime := 3.0

## Direction the projectile is travelling in
var direction := Vector2.ZERO

## How long this projectile will persist
var _lifetime_counter := 3.0


func get_damage() -> int:
	return damage + Powerup.damage_modifier


## Reset lifetime for new bullets
func _on_spawn():
	_lifetime_counter = lifetime


## Simple movement and lifetime checker
func _process(delta: float) -> void:
	position += speed * delta * direction

	_lifetime_counter -= delta
	if _lifetime_counter < 0.0:
		release()


## Logic on hitting enemies
func _on_area_2d_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy is Enemy:
		enemy.hit_by(self)
		if not piercing:
			release()


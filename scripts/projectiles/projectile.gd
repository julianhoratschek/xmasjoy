class_name Projectile extends PooledObject


"""
Base class for all projectiles
"""


## Flying speed of projectile
var speed := 400

## Damage done when projectile hits enemy
var damage := 25

## Direction the projectile is travelling in
var direction := Vector2.ZERO

## True is projectile won't despawn when an enemy was hit
var piercing := false

## How much an enemy is pushed back on hit
var pushback := 20.0

## How long until this object is released
var lifetime := 3.0

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


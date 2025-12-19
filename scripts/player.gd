class_name Player extends Node2D

"""
Class for Player-character
"""

## Emitted when player is leveled up
signal level_up()

## Movement speed
var speed := 200.0

## Player health
var health := 100

## Current player XP
var xp := 0

## Powerups currently held by the player
# Each instants keeps track of its own level
var powerups: Dictionary[String, Powerup] = {}


## Add a new power-up or level up an existing one
# TODO: Better done with string-name and power-ups here?
func add_powerup(powerup: Powerup):
	if not powerups.has(powerup.name):
		powerups[powerup.name] = powerup
	powerups[powerup.name].stack_callback()


## Called when player was hit by an enemy
# TODO: Extend for enemy-bullets?
func hit_by(enemy: Enemy) -> void:
	health -= enemy.damage
	$HealthBar.value = health

	if health <= 0:
		# TODO: Game over
		pass


## Start game with Star-Powerup
func _ready() -> void:
	add_powerup(StarPU.new())


## Simple movement and call to Powerups
func _process(delta: float):
	var dir := Input.get_vector(&"gme_left", &"gme_right", &"gme_up", &"gme_down")
	position += dir * speed * delta

	# Tick times and calls a powerup
	for powerup in powerups.values():
		powerup.tick(delta)


## Hit-detection on player
# TODO: Extend for enemy-projectiles?
func _on_area_2d_area_entered(area: Area2D) -> void:
	var body = area.get_parent()

	if body is Enemy:
		hit_by(body)

	elif body is XPBall:
		xp += body.amount
		body.collect()
		if xp >= 30:
			xp = 0
			level_up.emit()





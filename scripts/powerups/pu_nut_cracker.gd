class_name NutCrackerPU extends Powerup

"""
Powerup spawning bites (stationary) periodically around the player,
dealing damage to all enemies in their area
"""

## Radius to spawn bite areas around the player
@export var radius := 400.0

## Pool for bullets
@onready
var pool := ObjectPool.new(
	preload("res://prefabs/projectiles/bite.tscn"),
	get_parent().get_parent())


## Spawn as many bite areas around the player as levels on this powerup
func process_callback():
	var parent = get_parent()
	for num in range(level):
		var new_bite: Projectile = pool.pop()
		if !new_bite:
			return

		var dir := Vector2.UP.rotated(randf_range(0.0, 2*PI))

		new_bite.position = parent.position + dir * randf_range(25.0, radius)






class_name CandyCanePU extends Powerup

"""
Spawns rotating candy cones around the player
"""

## Pool for bullets
@onready
var pool := ObjectPool.new(
	preload("res://prefabs/projectiles/candy_cane.tscn"),
	get_parent())


## Access all currently spawned canes
var _canes: Array[Projectile] = []

## How much every cane rotates per callback
var _rotation_amount := 0.01


## Rotate _candy_cane around player
func process_callback():
	for cane in _canes:
		cane.rotate(_rotation_amount)


## Clear and reset all canes per level-up around the player
func stack_callback():
	super()

	pool.release_all()
	_canes.clear()

	var ang := (2.0 * PI) / level
	var rot := 0.0

	for n in range(level):
		var new_candy := pool.pop() as Projectile
		_canes.append(new_candy)
		new_candy.rotation = rot
		rot += ang

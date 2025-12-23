class_name CandyCanePU extends Powerup

"""
Spawns a rotating candy cone
Level-Up:
	- Candy Cone rotates faster
"""

## Prefab to spawn CandyCone-"Bullet"
# const CandyCanePrefab := preload("res://prefabs/projectiles/candy_cane.tscn")

@onready
var pool := ObjectPool.new(
	preload("res://prefabs/projectiles/candy_cane.tscn"),
	get_parent())

var _canes: Array[Projectile] = []

var _rotation_amount := 0.01


## Rotate _candy_cane around player
func process_callback():
	# _candy_cane.rotate(_rotation_amount)
	for cane in _canes:
		cane.rotate(_rotation_amount)


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

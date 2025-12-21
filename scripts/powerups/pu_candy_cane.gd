class_name CandyCanePU extends Powerup

"""
Spawns a rotating candy cone
Level-Up:
	- Candy Cone rotates faster
"""

## Prefab to spawn CandyCone-"Bullet"
const CandyCanePrefab := preload("res://prefabs/projectiles/candy_cane.tscn")

## Reference of spawned CandyCone-"Bullet"
var _candy_cane: Node2D = null

## How much _candy_cane rotates per call
var _rotation_amount := 0.0


## Rotate _candy_cane around player
func process_callback():
	_candy_cane.rotate(_rotation_amount)


## Levelling up will make _candy_cane rotate faster
func stack_callback():
	if not _candy_cane:
		_candy_cane = CandyCanePrefab.instantiate()
		add_sibling(_candy_cane)
	super()
	_rotation_amount = -level * 0.01

class_name TinSoldierPU extends Powerup


"""
Spawns a bullet that flies in a random direction and causes high damage
Level-Up:
	- More random bullets spawn at once
"""

@onready
var pool := ObjectPool.new(
	preload("res://prefabs/projectiles/tin_soldier_bullet.tscn"),
	get_parent().get_parent())


func process_callback():
	var parent = get_parent()
	for num in range(level):
		var new_bullet: Projectile = pool.pop()

		new_bullet.position = parent.position
		new_bullet.direction = Vector2.UP.rotated(randf_range(0, 2 * PI))
		new_bullet.look_at(new_bullet.position + new_bullet.direction * 50)

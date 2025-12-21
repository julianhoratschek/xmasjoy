class_name TinSoldierPU extends Powerup


"""
Spawns a bullet that flies in a random direction and causes high damage
Level-Up:
	- More random bullets spawn at once
"""

const BulletScene := preload("res://prefabs/projectiles/tin_soldier_bullet.tscn")


func process_callback():
	for num in range(level):
		var new_bullet: Projectile = BulletScene.instantiate()

		new_bullet.position = player.position
		new_bullet.direction = Vector2.UP.rotated(randf_range(0, 2 * PI))
		new_bullet.look_at(new_bullet.position + new_bullet.direction * 50)
		player.add_sibling(new_bullet)


func _init() -> void:
	frequency = 5.0
	name = "tin_soldier"

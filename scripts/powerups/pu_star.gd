class_name StarPU extends Powerup


"""
Most basic Powerup
Shoots Stars in the direction of the cursor
Level-Up:
	- Higher frequency of star-shootings
"""


const StarScene := preload("res://prefabs/projectiles/star.tscn")


func process_callback():
	# var star: Projectile = StarScene.instantiate()
	var parent = get_parent()
	var star: Projectile = StarScene.instantiate()

	star.position = parent.position
	star.direction = parent.position.direction_to(
		parent.get_global_mouse_position())
	parent.add_sibling(star)


func stack_callback():
	super()
	frequency = 0.8 - level * 0.05

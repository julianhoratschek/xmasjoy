class_name StarPU extends Powerup


"""
Most basic Powerup
Shoots Stars in the direction of the cursor
Level-Up:
	- Higher frequency of star-shootings
"""


const StarScene := preload("res://prefabs/projectiles/star.tscn")


func process_callback():
	var star: Projectile = StarScene.instantiate()

	star.position = player.position
	star.direction = player.position.direction_to(
		player.get_global_mouse_position())
	player.add_sibling(star)


func stack_callback():
	super()
	frequency = 0.8 - level * 0.05


func _init() -> void:
	frequency = 0.8
	name = "star"

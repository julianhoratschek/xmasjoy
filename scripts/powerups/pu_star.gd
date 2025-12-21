class_name StarPU extends Powerup


"""
Most basic Powerup
Shoots Stars in the direction of the cursor
Level-Up:
	- Higher frequency of star-shootings
"""


@onready
var pool: ObjectPool = ObjectPool.new(
	preload("res://prefabs/projectiles/star.tscn"),
	get_parent().get_parent()
)


func process_callback():
	var parent = get_parent()
	var star = pool.pop()

	star.position = parent.position
	star.direction = parent.position.direction_to(
		parent.get_global_mouse_position())


func stack_callback():
	super()
	frequency = 0.8 - level * 0.05

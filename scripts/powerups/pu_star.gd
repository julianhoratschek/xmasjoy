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

	var spread_angle = deg_to_rad(5.0 + level * 5.0)
	var direction = parent.position.direction_to(
		parent.get_global_mouse_position()
	).angle()

	for n in range(level):
		var star = pool.pop()
		if !star:
			return

		var rot_dir = direction

		if level > 1:
			var ratio = float(n) / float(level - 1)
			rot_dir += (ratio - 0.5) * spread_angle

		star.position = parent.position
		star.direction = Vector2.RIGHT.rotated(rot_dir)

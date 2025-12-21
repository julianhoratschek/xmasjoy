class_name NutCrackerPU extends Powerup


@export
var radius := 400.0


@onready
var pool := ObjectPool.new(
	preload("res://prefabs/projectiles/bite.tscn"),
	get_parent().get_parent())


func process_callback():
	var parent = get_parent()
	for num in range(level):
		var new_bite: Projectile = pool.pop()
		var dir := Vector2.UP.rotated(randf_range(0.0, 2*PI))

		new_bite.position = parent.position + dir * randf_range(25.0, radius)






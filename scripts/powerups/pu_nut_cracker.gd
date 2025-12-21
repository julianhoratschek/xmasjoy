class_name NutCrackerPU extends Powerup


const BiteScene := preload("res://prefabs/projectiles/bite.tscn")


@export
var radius := 400.0


func process_callback():
	var parent = get_parent()
	for num in range(level):
		var new_bite: Projectile = BiteScene.instantiate()
		var dir := Vector2.UP.rotated(randf_range(0.0, 2*PI))

		new_bite.position = parent.position + dir * randf_range(25.0, radius)
		parent.add_sibling(new_bite)






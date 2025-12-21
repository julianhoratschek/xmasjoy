class_name NutCrackerPU extends Powerup


const BiteScene := preload("res://prefabs/projectiles/bite.tscn")


var radius := 400.0


func process_callback():
	for num in range(level):
		var new_bite: Projectile = BiteScene.instantiate()
		var dir := Vector2.UP.rotated(randf_range(0.0, 2*PI))

		new_bite.position = player.position + dir * randf_range(25.0, radius)
		player.add_sibling(new_bite)


func _init() -> void:
	frequency = 3.0
	name = "nut_cracker"




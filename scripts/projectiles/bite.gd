extends Projectile

"""
Stationary projectile-Type spawning periodically around the player
and deals damage
"""

func _on_spawn():
	super()
	$AnimatedSprite2D.play("bite")


func _on_bite_finished() -> void:
	var overlaps = $Area2D.get_overlapping_areas()
	for area in overlaps:
		var enemy = area.get_parent()
		if enemy is Enemy:
			enemy.hit_by(self)



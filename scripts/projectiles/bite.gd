extends Projectile

"""
Stationary projectile-Type spawning periodically around the player
and deals damage
"""

func _on_spawn():
	super()
	$AnimatedSprite2D.play("default")



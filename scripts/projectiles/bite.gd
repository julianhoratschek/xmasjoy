extends Projectile


func _on_spawn():
	super()
	$AnimatedSprite2D.play("default")



extends Enemy


var _hit_fn = _on_first_hit


func _on_spawn():
	super()
	_hit_fn = _on_first_hit
	$AnimatedSprite2D.animation = "unlit"


func _on_first_hit(projectile: Projectile) -> void:
	super.hit_by(projectile)
	$AnimatedSprite2D.animation = "lit"
	speed = 120
	damage = 30
	_hit_fn = _on_hit


func _on_hit(projectile: Projectile) -> void:
	super.hit_by(projectile)


func hit_by(projectile: Projectile) -> void:
	_hit_fn.call(projectile)


extends Enemy


var _hit_fn = _on_first_hit


func _on_first_hit(projectile: Projectile) -> void:
	super.hit_by(projectile)
	$AnimatedSprite2D.animation = "lit"
	speed = 120
	damage = 20
	_hit_fn = _on_hit


func _on_hit(projectile: Projectile) -> void:
	super.hit_by(projectile)


func _ready() -> void:
	health = 120
	speed = 20
	damage = 5
	xp = 20


func hit_by(projectile: Projectile) -> void:
	_hit_fn.call(projectile)


extends Projectile


func _ready() -> void:
	damage = 40
	piercing = true
	pushback = 0.0
	lifetime = 1.0


func _on_spawn():
	super()
	$AnimatedSprite2D.play("default")



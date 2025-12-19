extends Projectile


"""
Basic projectile
Managed by StarPU
"""

## How fast does the star rotate
var rotation_speed := 5.0


func _ready() -> void:
	pushback = 10
	speed = 400
	damage = 25


## Add star rotation
func _process(delta: float) -> void:
	rotation_degrees += rotation_speed
	super(delta)


func _on_area_2d_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy is Enemy:
		enemy.hit_by(self)


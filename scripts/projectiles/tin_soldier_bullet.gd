extends Projectile


"""
High-damage bullet
Managed by TinSoldierPU
"""


func _ready() -> void:
	pushback = 20
	speed = 400
	damage = 120


func _on_area_2d_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy is Enemy:
		enemy.hit_by(self)


extends Projectile

"""
Piercing, rotating projectile that persists around the player
Spawned and controlled by CandyConePU
"""

func _ready() -> void:
	pushback = 0
	damage = 12
	piercing = true


## Override _process, because this is not an ordinary projectile
func _process(_delta: float) -> void:
	pass


# func _on_area_2d_area_entered(area: Area2D) -> void:
# 	var enemy = area.get_parent()
# 	if enemy is Enemy:
# 		enemy.hit_by(self)


extends Enemy


"""
Staged enemy, that grows faster, if it was hit once
"""

## Method to call on hit (different on the first time)
var _hit_fn = _on_first_hit


## Set own starting animation
func _ready() -> void:
	_starting_animation = "match_unlit"


## Reset animation and hit-function
func _on_spawn():
	super()
	_hit_fn = _on_first_hit


## Called on first bullet hit, changes behaviour
func _on_first_hit(projectile: Projectile) -> void:
	super.hit_by(projectile)
	$AnimatedSprite2D.play(&"match_lit")
	speed = 160
	damage = 30
	_hit_fn = _on_hit


## Called on consecutive times then hit (just super.hit_by)
func _on_hit(projectile: Projectile) -> void:
	super.hit_by(projectile)


## Override to call different functions
func hit_by(projectile: Projectile) -> void:
	_hit_fn.call(projectile)


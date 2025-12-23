extends Enemy


"""
Enemy in multiple stages
"""
# TODO: The stages

## Override to flip while moving
func _process(delta: float) -> void:
	super(delta)
	$AnimatedSprite2D.flip_h = _direction.x > 0

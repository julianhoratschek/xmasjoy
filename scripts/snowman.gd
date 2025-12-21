extends Enemy


func _process(delta: float) -> void:
	super(delta)
	$Sprite2D.flip_h = _direction.x > 0

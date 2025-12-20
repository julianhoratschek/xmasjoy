extends Enemy


func _ready() -> void:
	health = 120
	speed = 80
	xp = 30


func _process(delta: float) -> void:
	super(delta)
	$Sprite2D.flip_h = _direction.x > 0

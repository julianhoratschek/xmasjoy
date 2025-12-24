extends Enemy


"""
Enemy in multiple stages
"""
# TODO: The stages

static var Stages = [
	{
		&"animation": &"snowman_stage_1",
		&"health": 80,
		&"speed": 80,
		&"damage": 20
	},

	{
		&"animation": &"snowman_stage_2",
		&"health": 60,
		&"speed": 60,
		&"damage": 10
	},

	{
		&"animation": &"snowman_stage_3",
		&"health": 40,
		&"speed": 160,
		&"damage": 20
	}
]


var _stage := 0


func _set_stage(new_stage: int) -> void:
	_stage = new_stage

	var values = Stages[_stage]

	$AnimatedSprite2D.animation = values[&"animation"]
	health = values[&"health"]
	speed = values[&"speed"]
	damage = values[&"damage"]


func hit_by(projectile: Projectile) -> void:
	health -= projectile.get_damage()

	if health <= 0:
		if _stage < 2:
			_set_stage(_stage + 1)
		else:
			death_animation()
			return

	position -= _direction * projectile.pushback



func _on_spawn():
	super()
	_set_stage(0)

## Override to flip while moving
func _process(delta: float) -> void:
	super(delta)
	$AnimatedSprite2D.flip_h = _direction.x > 0

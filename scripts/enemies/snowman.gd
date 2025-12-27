extends Enemy


"""
Enemy in multiple stages
"""

## Stages and values of each stage
static var Stages = [
	# Stage 1 (Full snowman)
	{
		&"animation": &"snowman_stage_1",
		&"health": 80,
		&"speed": 80,
		&"damage": 20
	},

	# Stage 2 (One segment missing)
	{
		&"animation": &"snowman_stage_2",
		&"health": 60,
		&"speed": 60,
		&"damage": 10
	},

	# Stage 3 (Only head remaining)
	{
		&"animation": &"snowman_stage_3",
		&"health": 40,
		&"speed": 160,
		&"damage": 20
	}
]

## Current stage (Array-index)
var _stage := 0


## Set current stage to new_stage, assign values
func _set_stage(new_stage: int) -> void:
	_stage = new_stage

	var values = Stages[_stage]

	$AnimatedSprite2D.play(values[&"animation"])
	health = values[&"health"]
	speed = values[&"speed"]
	damage = values[&"damage"]


## Override hit_by to have stage-transitions
func hit_by(projectile: Projectile) -> void:
	health -= projectile.get_damage()

	if health <= 0:
		if _stage < 2:
			_set_stage(_stage + 1)
		else:
			death_animation()
			return

	position -= _direction * projectile.pushback



## Reset stage to 0 (stage 1) on spawn
func _on_spawn():
	super()
	_set_stage(0)


## Override to flip while moving
func _process(delta: float) -> void:
	super(delta)
	$AnimatedSprite2D.flip_h = _direction.x > 0

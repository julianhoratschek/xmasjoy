extends Enemy


enum State {
	Standing,
	Digging
}

static var StateValues := {
	State.Standing: {
		&"animation": &"tree_standing",
		&"min_time": 1.5,
		&"max_time": 2.8,
		&"process_mode": Node.PROCESS_MODE_INHERIT
	},

	State.Digging: {
		&"animation": &"tree_moving",
		&"min_time": 0.8,
		&"max_time": 3.0,
		&"process_mode": Node.PROCESS_MODE_DISABLED
	}
}


var _state := State.Standing

var _state_counter := 0.0


## Invincible while digging
func hit_by(projectile: Projectile) -> void:
	if _state == State.Digging:
		return

	super(projectile)


func _change_state(new_state: State) -> void:
	var values = StateValues[new_state]

	_state = new_state
	_state_counter += randf_range(values[&"min_time"], values[&"max_time"])
	$AnimatedSprite2D.play(values[&"animation"])
	$Area2D.process_mode = values[&"process_mode"]


func _ready() -> void:
	_starting_animation = &"tree_moving"


func _process(delta: float):
	_state_counter -= delta

	match _state:
		State.Digging:
			super(delta)
			$AnimatedSprite2D.flip_h = _direction.x > 0
			if _state_counter < 0:
				_change_state(State.Standing)

		State.Standing when _state_counter < 0:
			_change_state(State.Digging)


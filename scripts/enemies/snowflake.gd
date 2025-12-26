extends Enemy


"""
Enemy locking onto the player and then moving quickly towards the last position
"""


## State of the enemy
enum State {
	# Standing still, resting
	LookingAround,

	# Telegraphing movement to begin soon
	WindUp,

	# Moving towards last position of player
	Charging
}

## States
static var NextStateValuesAfter = {
	State.LookingAround: {
		&"next": State.WindUp,
		&"rot": 5.0,
		&"time": 0.8
	},

	State.WindUp: {
		&"next": State.Charging,
		&"rot": 40.0,
		&"time": 2.8
	},

	State.Charging: {
		&"next": State.LookingAround,
		&"rot": 0.0,
		&"time": 0.8
	}
}

## Current state
var _state := State.LookingAround

## Duration until change to next state
var _state_counter := 0.0

## How fast the sprite rotates
var rot_speed := 0.7


## Change to next state according to NextStateValuesAfter
func change_state() -> void:
	var values = NextStateValuesAfter[_state]

	rot_speed = values[&"rot"]
	_state_counter += values[&"time"]
	_state = values[&"next"]


## Override _process to handle state switching according to timer
func _process(delta: float) -> void:
	_state_counter -= delta
	match _state:
		State.LookingAround:
			pass

		State.WindUp:
			rotation -= rot_speed * delta
			_direction = position.direction_to(player.position)

		State.Charging:
			rotation += rot_speed * delta
			position += _direction * speed * delta
	
	if _state_counter < 0:
		change_state()
	

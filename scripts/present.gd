class_name Present extends Node2D


enum State {
	Waiting,
	InRange,
	Teleporting
}


signal teleported()
signal collected()


@export var player: Player = null

@export var wait_time_min := 1.0
@export var wait_time_max := 3.0

@export var min_teleport_range := 400.0
@export var max_teleport_range := 900.0

@export var min_teleport_delay := 5.0
@export var max_teleport_delay := 15.0

@export var value_step := 4.0
@export var step_duration := 0.2

var _step_counter := 0.0

var _state := State.Waiting


func _teleport() -> void:
	var dir := Vector2.UP.rotated(randf_range(0.0, 2 * PI))
	position = player.position + dir * randf_range(min_teleport_range, max_teleport_range)

	_state = State.Waiting

	$Area2D.process_mode = Node.PROCESS_MODE_INHERIT
	$TextureProgressBar.value = 0

	show()
	teleported.emit()


## Only player bodys can enter or exit
func _on_area_entered(_area: Area2D):
	if _state == State.Waiting:
		_state = State.InRange


func _on_area_exited(_area: Area2D):
	if _state == State.InRange:
		_state = State.Waiting


func _on_progress_bar_changed(value: float):
	if value < 100:
		return

	_state = State.Teleporting
	$Area2D.process_mode = Node.PROCESS_MODE_DISABLED
	_step_counter = randf_range(min_teleport_delay, max_teleport_delay)
	value = 0
	hide()

	collected.emit()


func _on_timer_timeout() -> void:
	var animation_name: String = [&"", &"shake", &"jump"].pick_random()

	match animation_name:
		&"":
			$Timer.start(randf_range(wait_time_min, wait_time_max))
			return

		&"jump" when _state == State.InRange:
			animation_name = &"shake"

	$AnimationPlayer.play(animation_name)


func _process(delta: float):
	if _step_counter > 0:
		_step_counter -= delta
		return

	match _state:
		State.InRange:
			if Input.is_action_pressed(&"gme_action"):
				$TextureProgressBar.value += value_step
				_step_counter += step_duration

		State.Teleporting:
			_teleport()

		State.Waiting:
			pass


func _on_animation_finished(_animation_name: StringName):
	$AnimationPlayer.stop()
	$Timer.start(randf_range(wait_time_min, wait_time_max))

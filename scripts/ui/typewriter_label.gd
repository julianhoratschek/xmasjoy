extends Label


enum State {
	Typing,
	Waiting,	# Display complete line, wait for new line
	Finished
}

signal finished()

@export var text_speed := 0.08
@export var complete_line_time := 1.2

var _lines: Array[String] = []
var _current_line := 0

var _display_counter := 0.0
var _state := State.Typing


func _new_line() -> void:
	_current_line += 1

	_display_counter += complete_line_time

	if _current_line >= _lines.size():
		_state = State.Finished
	else:
		_state = State.Waiting


func _ready() -> void:
	for line in text.split("\n"):
		_lines.append(line)

	text = _lines[_current_line]
	visible_ratio = 0
	

func _process(delta: float) -> void:
	_display_counter -= delta

	if _display_counter > 0:
		return

	match _state:
		State.Typing:
			visible_characters += 1
			if visible_ratio >= 1:
				_new_line()
			else:
				_display_counter += text_speed

		State.Waiting:
			text = _lines[_current_line]
			visible_ratio = 0
			_state = State.Typing
			_display_counter += text_speed

		State.Finished:
			process_mode = Node.PROCESS_MODE_DISABLED
			finished.emit()


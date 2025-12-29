extends Label


"""
Very simple typewriter-effect for Label-Control
"""


## State of the label
enum State {
	## Currently typing text
	Typing,

	## Currently waiting at the end of a line, before loading new line
	Waiting,

	## Finished text on the label
	Finished
}


## Emitted after the last line was printed
signal finished()

## How fast characters are displayed
@export var text_speed := 0.08

## How long to wait after a line was completed
@export var complete_line_time := 1.2

## All text lines
var _lines: Array[String] = []

## Currently displayed text line
var _current_line := 0

## Timer for character-display (typing-effect)
var _display_counter := 0.0

## Current state of the label
var _state := State.Typing


## Increment current line and set Waiting or Finished state
func _new_line() -> void:
	_current_line += 1

	_display_counter += complete_line_time

	if _current_line >= _lines.size():
		_state = State.Finished
	else:
		_state = State.Waiting


## Read text lines from label input
func _ready() -> void:
	for line in text.split("\n"):
		_lines.append(line)

	text = _lines[_current_line]
	visible_ratio = 0
	

## Check states and act on them
func _process(delta: float) -> void:
	_display_counter -= delta

	if _display_counter > 0:
		return

	match _state:
		# Display more characters, call _new_line on complete line
		State.Typing:
			visible_characters += 1
			if visible_ratio >= 1:
				_new_line()
			else:
				_display_counter += text_speed

		# Load next text line
		State.Waiting:
			text = _lines[_current_line]
			visible_ratio = 0
			_state = State.Typing
			_display_counter += text_speed

		# Emit finished-signal and stop processing this node
		State.Finished:
			process_mode = Node.PROCESS_MODE_DISABLED
			finished.emit()


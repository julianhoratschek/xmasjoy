extends Node2D

"""
Main Scene script
Top-level assignments are made here
"""

@onready var powerup_selection := $CanvasLayer/PowerupSelection


# Set static variables to point at player
func _ready() -> void:
	Enemy.player = $Player
	Powerup.player = $Player


# Bubbled up from PowerupSelection-UI
func _on_powerup_selection_powerup_selected(powerup: Powerup) -> void:
	$Player.add_powerup(powerup)


# Show PowerupSelection-UI on level-up
func _on_player_level_up() -> void:
	powerup_selection.show()


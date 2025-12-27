extends Node2D

"""
Main Scene script
Top-level assignments are made here
"""

# TODO:
# - Fix bites
# - Pause/Options screen
# - game over
# - List of powerups
# - OOB management
# - Player and threatlevel
# - UI for timekeeping?
# - Savefile
# - Structures

@onready var powerup_selection := $CanvasLayer/PowerupSelection

## Maximum level for enemy spawners
const max_threat_level = 19

## Current level of enemy spawners
var current_threat := 0

## Per-level values for enemy spawners
var threat_levels: Dictionary = JSON.parse_string(
	FileAccess.get_file_as_string(
		"res://data/threat_level.json")
)


## Set spawner values according to current threat-level
# TODO: hardwire these?
func update_spawners() -> void:
	var spawners = $Spawners

	for key in threat_levels.keys():
		var spawner = spawners.find_child(key)
		if not spawner:
			continue

		spawner.set_values(
			threat_levels[key][current_threat])


# Set static variables to point at player
func _ready() -> void:
	var joy_level_label = $CanvasLayer/JoyLevelLabel
	joy_level_label.pivot_offset = joy_level_label.size / 2

	Enemy.player = $Player

	update_spawners()


# Bubbled up from PowerupSelection-UI
func _on_powerup_selection_powerup_selected(powerup: Powerup) -> void:
	$Player.add_powerup(powerup)


## Called when a present is collected
func _on_present_collected() -> void:
	powerup_selection.show()


## Show PowerupSelection-UI on level-up
func _on_player_level_up() -> void:
	powerup_selection.show()


## Update label when xp is collected
func _on_player_xp_collected() -> void:
	$CanvasLayer/XPLabel.text = "XP: %d / %d" % [
		$Player.xp, 
		$Player.next_level_xp]


## Increase threat-level periodically
func _on_timer_timeout() -> void:
	if current_threat >= max_threat_level:
		$JoyTimer.stop()
		return

	current_threat += 1

	var label = $CanvasLayer/JoyLevelLabel
	label.text = "Joy Level %d" % current_threat
	$CanvasLayer/JoyLevelLabel/AnimationPlayer.play("fade_in_out")

	update_spawners()

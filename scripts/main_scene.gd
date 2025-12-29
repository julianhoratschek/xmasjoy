extends Node2D

"""
Main Scene script
Top-level assignments are made here
"""

# TODO:
# - Player and threatlevel
# - UI for timekeeping?
# - Savefile
# - Structures

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
	var joy_level_label = %JoyLevelLabel
	joy_level_label.pivot_offset = joy_level_label.size / 2

	Enemy.player = $Player

	update_spawners()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed():
			%GameOverScreen.activate_screen(GameOverScreen.ScreenType.PauseScreen)


# Bubbled up from PowerupSelection-UI
func _on_powerup_selection_powerup_selected(powerup: Powerup) -> void:
	$Player.add_powerup(powerup)
	%PowerupTray.add_powerup(powerup)


## Called when a present is collected
func _on_present_collected() -> void:
	%PowerupSelection.show()


## Show PowerupSelection-UI on level-up
func _on_player_level_up() -> void:
	%PowerupSelection.show()


## Update label when xp is collected
func _on_player_xp_collected() -> void:
	%XPLabel.text = "XP: %d / %d" % [
		$Player.xp, 
		$Player.next_level_xp]


## Called, when player dies
func _on_player_dead() -> void:
	%GameOverScreen.activate_screen(GameOverScreen.ScreenType.GameOverScreen)


## Increase threat-level periodically
func _on_timer_timeout() -> void:
	if current_threat >= max_threat_level:
		$JoyTimer.stop()
		return

	current_threat += 1

	var label = %JoyLevelLabel
	label.text = "Joy Level %d" % current_threat
	%JoyLevelLabel/AnimationPlayer.play("fade_in_out")

	update_spawners()

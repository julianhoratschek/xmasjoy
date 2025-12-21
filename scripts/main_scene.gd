extends Node2D

"""
Main Scene script
Top-level assignments are made here
"""

@onready var powerup_selection := $CanvasLayer/PowerupSelection


const max_threat_level = 7
var current_threat := 0
var threat_levels: Dictionary = JSON.parse_string(
	FileAccess.get_file_as_string(
		"res://data/threat_level.json")
)


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
	Enemy.player = $Player
	# Powerup.player = $Player
	# ObjectPool.MainScene = self

	update_spawners()


# Bubbled up from PowerupSelection-UI
func _on_powerup_selection_powerup_selected(powerup: Powerup) -> void:
	$Player.add_powerup(powerup)


# Show PowerupSelection-UI on level-up
func _on_player_level_up() -> void:
	powerup_selection.show()


func _on_timer_timeout() -> void:
	if current_threat >= max_threat_level:
		$Timer.stop()
		return

	current_threat += 1

	var label = $CanvasLayer/JoyLevelLabel
	label.text = "Joy Level %d" % current_threat
	$CanvasLayer/JoyLevelLabel/AnimationPlayer.play("fade_in_out")

	update_spawners()

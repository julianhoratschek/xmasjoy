extends Control


"""
Display-control for powerups on the screen
"""


## Set display and connect powerup.level_up to update display
func set_powerup(powerup: Powerup) -> void:
	$TextureRect.texture = powerup.display_image
	$TextureRect/Label.text = "x%d" % powerup.level
	powerup.leveled_up.connect(_on_powerup_leveled_up)


## Update display on powerup level-up
func _on_powerup_leveled_up(level: int) -> void:
	$TextureRect/Label.text = "x%d" % level



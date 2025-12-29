extends Control


"""
Small tray at the screen-bottom to display all powerups
"""


## Scene for tray icons
const TrayIconScene = preload("res://ui/powerup_tray_icon.tscn")

## All currently displayed powerups
var _powerups: Array[Powerup] = []


## Add a new powerup, if it is not displayed yet
func add_powerup(powerup: Powerup) -> void:
	if powerup in _powerups:
		return

	var tray = TrayIconScene.instantiate()
	
	$HBoxContainer.add_child(tray)
	tray.set_powerup(powerup)
	_powerups.append(powerup)



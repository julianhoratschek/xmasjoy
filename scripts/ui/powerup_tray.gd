extends Control


const TrayIconScene = preload("res://ui/powerup_tray_icon.tscn")

var _powerups: Array[Powerup] = []


func add_powerup(powerup: Powerup) -> void:
	if powerup in _powerups:
		return

	var tray = TrayIconScene.instantiate()
	
	$HBoxContainer.add_child(tray)
	tray.set_powerup(powerup)
	_powerups.append(powerup)



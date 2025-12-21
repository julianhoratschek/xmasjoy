extends Panel

"""
Tile to display one single Powerup for selection
"""

## Emitted when this Powerup was selected
signal powerup_selected(powerup: Powerup)


## Property to set content
# value should be a dictionary containing "image", "name" and "powerup" fields
var content: Powerup:
	set(value):
		$VBoxContainer/TextureRect.texture = value.display_image
		$VBoxContainer/NameLabel.text = value.display_name
		_powerup = value


## Represents currently held powerup
var _powerup: Powerup = null


## Animation on Mouse Enter
func _on_mouse_entered() -> void:
	z_index = 1
	create_tween().tween_property(self, "scale", Vector2(1.2, 1.2), 0.5)
	$AnimationPlayer.play("mouse_over")


## Animation on Mouse Exit
func _on_mouse_exit() -> void:
	z_index = 0
	create_tween().tween_property(self, "scale", Vector2(1.0, 1.0), 0.5)
	$AnimationPlayer.stop()


## Emits powerup_selected when this was clicked
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT \
			and event.is_pressed():
				powerup_selected.emit(_powerup)

class_name GameOverScreen extends Control


## Type of the currently displayed screen
enum ScreenType {
	PauseScreen,
	GameOverScreen
}

## Current type, some functionality and display will change depending on this
## value
var _type := ScreenType.PauseScreen


## Activate screen either as pause or as game over screen
## Pauses scene tree
func activate_screen(show_as: ScreenType) -> void:
	get_tree().paused = true
	_type = show_as

	match _type:
		ScreenType.PauseScreen:
			$VBoxContainer/CaptionLabel.text = "Joy Paused"
			$VBoxContainer/PlayButton.text = "Continue"

		ScreenType.GameOverScreen:
			$VBoxContainer/CaptionLabel.text = "Oh Joyful!"
			$VBoxContainer/PlayButton.text = "Play again!"

	show()


## Play/Continue game
func _on_play_button_pressed() -> void:
	match _type:
		ScreenType.PauseScreen:
			get_tree().paused = false
			hide()

		ScreenType.GameOverScreen:
			get_tree().paused = false
			get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


## Quit game
func _on_quit_button_pressed() -> void:
	get_tree().quit()

extends Control


"""
Simple main menu screen
"""


## Begin game
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


## Display Options
func _on_options_button_pressed() -> void:
	# TODO: implement
	pass


## Quit game
func _on_exit_button_pressed() -> void:
	get_tree().quit()

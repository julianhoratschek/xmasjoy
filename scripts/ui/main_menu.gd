extends Control


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")


func _on_options_button_pressed() -> void:
	# TODO: implement
	pass


func _on_exit_button_pressed() -> void:
	get_tree().quit()

class_name Step extends PooledObject


func _on_spawn():
	$Sprite2D.modulate = Color(1, 1, 1, 0.75)

	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0), 4.0)
	tween.finished.connect(_on_fade_finished)


func _on_fade_finished():
	release()


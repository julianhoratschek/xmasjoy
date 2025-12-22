class_name Step extends PooledObject


"""
Small scene representing fading footprints in the snow
"""

## Time it takes for the footprints to become invisible
const FadeOutTime := 4.0


## Called on instantiation, starts tween to fade out footprints
func _on_spawn():
	$Sprite2D.modulate = Color(1, 1, 1, 0.75)

	var tween = create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(1, 1, 1, 0), FadeOutTime)
	tween.finished.connect(_on_fade_finished)


## Called when tween is done to release resource into pool
func _on_fade_finished():
	release()


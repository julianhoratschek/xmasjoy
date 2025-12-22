extends Sprite2D


"""
Arrow always pointing at the newly spawned present
"""

# TODO: More than a mere arrow?


## Player instance
@export var player: Player = null

## Present instance
@export var present: Present = null

## Center to rotate arrow around
@onready var viewport_center := get_viewport_rect().get_center()


## Always point at the current present
func _process(_delta: float) -> void:
	var dir = player.position.direction_to(present.position)

	position = viewport_center + dir * 120
	look_at(present.get_global_transform_with_canvas().origin)


## Display when a present is spawned in
func _on_present_teleported():
	show()


## Hide when present was collected
func _on_present_collected():
	hide()

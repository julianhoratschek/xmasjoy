extends Sprite2D


@export var player: Player = null
@export var present: Present = null


@onready var viewport_center := get_viewport_rect().get_center()


func _process(_delta: float) -> void:
	var dir = player.position.direction_to(present.position)

	position = viewport_center + dir * 120
	look_at(present.get_global_transform_with_canvas().origin)


func _on_present_teleported():
	show()


func _on_present_collected():
	hide()

class_name XPBall extends Node2D


"""
XP-Collectables
"""

# TODO: As poolable resource?

## Amount of xp received when picking this instance up
var amount := 0

## How fast does the xp float towards player?
var _speed := 100

## Currently floating towards player?
var move_to_player := false


## Free self as soon as the text faded out
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "fade":
		return
	queue_free()


## Call on collection
# This will start a short text-fadeout-animation
func collect() -> void:
	$AnimatedSprite2D.hide()
	$ScoreLabel.text = "+%d" % amount
	$ScoreLabel.show()
	$ScoreLabel/AnimationPlayer.play("fade")


## Move xp ball towards player, when move_to_player is true
func _process(delta: float) -> void:
	if !move_to_player:
		return

	var player_position := Enemy.player.position

	position += position.direction_to(player_position) * _speed * delta


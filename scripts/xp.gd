class_name XPBall extends Node2D


"""
XP-Collectables
"""

# TODO: As poolable resource?
# TODO: For presents?

## Amount of xp received when picking this instance up
var amount := 0


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

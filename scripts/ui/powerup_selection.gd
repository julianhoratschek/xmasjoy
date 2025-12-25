extends Panel

"""
UI-Element to present player with different Powerups to choose
"""

## Emitted when a powerup was chosen
signal powerup_selected(powerup: String)

@export var powerups: Array[Powerup] = []

## Used to find powerups (as children of player)
# TODO: Rather have another node for this?
# TODO: Or have all powerups setup manually?
# @export var player: Player = null

## List of all found powerups
# var content: Array[Powerup] = []


## Sets new selection (does not check for double-selections)
func reroll() -> void:
	for tile in $VBoxContainer/PowerupTiles.get_children():
		tile.content = powerups.pick_random()


## Fill content with powerup-nodes found as children of player
# func _ready() -> void:
# 	for pu_node in player.find_children("Pu*", "Powerup", false):
# 		content.append(pu_node)


## Called when a powerup was selected (by PowerupTile)
func _on_powerup_selected(powerup: Powerup):
	powerup_selected.emit(powerup)
	hide()


## Pauses and unpauses SceneTree when this is displayed
func _on_visibility_changed() -> void:
	# Necessary, as godot calls this before tree_enter
	if not is_node_ready():
		return

	if visible:
		reroll()

	get_tree().paused = visible

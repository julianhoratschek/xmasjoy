extends Panel

"""
UI-Element to present player with different Powerups to choose
"""

## Emitted when a powerup was chosen
signal powerup_selected(powerup: String)

@export
var player: Player = null

var content: Array[Powerup] = []

## Sets new selection (does not check for double-selections)
func reroll() -> void:
	for tile in $VBoxContainer/PowerupTiles.get_children():
		tile.content = content.pick_random()


func _ready() -> void:
	for pu_node in player.find_children("Pu*", "Powerup", false):
		content.append(pu_node)


## Called when a powerup was selected (by PowerupTile)
func _on_powerup_selected(powerup: Powerup):
	powerup_selected.emit(powerup)
	hide()


## Pauses and unpauses SceneTree when this is displayed
func _on_visibility_changed() -> void:
	if not is_node_ready():
		return

	if visible:
		reroll()

	get_tree().paused = visible

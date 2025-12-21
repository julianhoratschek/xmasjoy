extends Panel

"""
UI-Element to present player with different Powerups to choose
"""

## Emitted when a powerup was chosen
signal powerup_selected(powerup: Powerup)

## All possible powerups
var content := [
	{
		"name": "Candy Cane",
		"image": preload("res://assets/sprites/candy_cane.png"),
		"powerup": CandyCanePU.new()
	},

	{
		"name": "X-Mas Star",
		"image": preload("res://assets/sprites/star.png"),
		"powerup": StarPU.new()
	},
	
	{
		"name": "Nut Cracker",
		"image": preload("res://assets/sprites/nut_cracker.png"),
		"powerup": NutCrackerPU.new()
	},

	{
		"name": "Tin Soldier",
		"image": preload("res://assets/sprites/tin_soldier.png"),
		"powerup": TinSoldierPU.new()
	}
]


## Sets new selection (does not check for double-selections)
func reroll() -> void:
	for tile in $VBoxContainer/PowerupTiles.get_children():
		tile.content = content.pick_random()


## Called when a powerup was selected (by PowerupTile)
func _on_powerup_selected(powerup: Powerup):
	powerup_selected.emit(powerup)
	hide()


## Pauses and unpauses SceneTree when this is displayed
func _on_visibility_changed() -> void:
	if visible:
		reroll()

	get_tree().paused = visible

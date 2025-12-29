extends TileMapLayer


"""
Very simple chunk management to simulate an endless map
"""

## Reference player instance
@export var player: Player

## How many chunks should be loaded around the player?
@export var chunk_lookahead := 3

## Tiles per chunk
var chunk_size := Vector2i(10, 10):
	get:
		return chunk_size
	set(value):
		chunk_size = value
		x_size = chunk_size.x + 1
		y_size = chunk_size.y + 1

## Tiles in chunk in x-direction
var x_size := chunk_size.x + 1

## Tiles in chunk in y-direction
var y_size := chunk_size.y + 1

## All loaded chunks
var _loaded_chunks: Dictionary[Vector2i, bool] = {}

## Current chunk containing player
var _current_chunk: Vector2i = Vector2i.ZERO


## Returns current chunk containing player mapped onto TiledMapLayer
func player_chunk() -> Vector2i:
	return (local_to_map(player.position) / chunk_size) as Vector2i


## Loads all chunks around the player
func load_surrounding() -> void:
	for x in range(_current_chunk.x - chunk_lookahead, _current_chunk.x + chunk_lookahead):
		for y in range(_current_chunk.y - chunk_lookahead, _current_chunk.y + chunk_lookahead):
			var pos := Vector2i(x, y)
			if _loaded_chunks.has(pos):
				continue
			fill_chunk(pos)
			_loaded_chunks[pos] = true


## Fills all Tiles within a chunk with a Terrain
func fill_chunk(chunk_pos: Vector2i):
	var start_x := chunk_pos.x * chunk_size.x
	var start_y := chunk_pos.y * chunk_size.y

	var new_cells: Array[Vector2i] = []

	new_cells.resize(x_size * y_size)

	var filled := 0
	for tile_x in range(start_x, start_x + x_size):
		for tile_y in range(start_y, start_y + y_size):
			new_cells[filled] = Vector2i(tile_x, tile_y)
			filled += 1
	
	set_cells_terrain_connect(new_cells, 0, 0)


## Checks, if player changed the chunk, if true, tries to load all chunks
## around the new chunk
func _process(_delta: float) -> void:
	var pos := player_chunk()
	if pos == _current_chunk:
		return
	_current_chunk = pos
	load_surrounding()

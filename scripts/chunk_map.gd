extends TileMapLayer

@export var player: Player
@export var chunk_lookahead := 3

var chunk_size := Vector2i(10, 10)
var x_size := chunk_size.x + 1
var y_size := chunk_size.y + 1

var _loaded_chunks: Dictionary[Vector2i, bool] = {}

var _current_chunk: Vector2i = Vector2i.ZERO


func player_chunk() -> Vector2i:
	return (local_to_map(player.position) / chunk_size) as Vector2i


func load_surrounding() -> void:
	for x in range(_current_chunk.x - chunk_lookahead, _current_chunk.x + chunk_lookahead):
		for y in range(_current_chunk.y - chunk_lookahead, _current_chunk.y + chunk_lookahead):
			var pos := Vector2i(x, y)
			if _loaded_chunks.has(pos):
				continue
			fill_chunk(pos)
			_loaded_chunks[pos] = true


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


func _process(_delta: float) -> void:
	var pos := player_chunk()
	if pos == _current_chunk:
		return
	_current_chunk = pos
	load_surrounding()

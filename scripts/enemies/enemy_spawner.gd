class_name EnemySpawner extends Node2D

"""
Spawner class for different Enemies
"""

## Radius around the player to spawn enemies
# TODO: make relative to screen/viewport resolution?
static var radius := 700.0

## Packed scene to show which enemy to spawn
@export var enemy_type: PackedScene = null

## Minimum amount of enemies to spawn per call
@export var min_enemies := 0

## Maximum amount of enemies to spawn per call
@export var max_enemies := 5

## Minimum time to pass between spawn calls
@export var spawn_timer_min := 2.0

## Maximum time to pass between spawn calls
@export var spawn_timer_max := 10.0

## Timer for next spawn call (between spawn_timer_min and spawn_timer_max)
var _spawn_timer := 0.0

## Counter for _spawn_timer
var _spawn_counter := 0.0

@onready
var pool := ObjectPool.new(
	enemy_type,
	get_parent().get_parent()
)


func set_values(threat_values: Dictionary) -> void:
	min_enemies = threat_values["min_enemies"]
	max_enemies = threat_values["max_enemies"]
	spawn_timer_min = threat_values["min_timer"]
	spawn_timer_max = threat_values["max_timer"]

	_spawn_timer = randf_range(spawn_timer_min, spawn_timer_max)
	_spawn_counter = randf_range(0.0, _spawn_timer)


## Periodically spawn n enemies around player
func _process(delta: float) -> void:
	_spawn_counter += delta
	if _spawn_counter < _spawn_timer:
		return
	_spawn_counter -= _spawn_timer
	_spawn_timer = randf_range(spawn_timer_min, spawn_timer_max)

	for n in range(randi_range(min_enemies, max_enemies)):
		# var new_enemy = enemy_type.instantiate()
		var new_enemy: Enemy = pool.pop()

		var dir := Vector2.UP.rotated(randf_range(0.0, 2*PI))
		var spawn_pos: Vector2 = Enemy.player.position + dir * radius

		new_enemy.position = spawn_pos
		# Enemy.player.add_sibling(new_enemy)

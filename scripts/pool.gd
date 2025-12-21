class_name ObjectPool extends Object


"""
Very simple indexed object pool
"""


## Starting size of pools
const PoolInitSize := 10

## Scene to instantiate in pool
# TODO: Allow different scenes?
var packed_scene: PackedScene = null

## Scene to append pooled object to on spawn
var parent_scene: Node2D = null

## Maximum size of pool
var max_size := 100

## List of available instantiated objects
var _obj_list: Array[PooledObject] = []

## List of indices of currently unused objects
# TODO: implement with PackedInt32Array?
var _free_idx: Array[int] = []


## Should only be called by PooledObject.release()
func _release(obj_index: int):
	_free_idx.push_back(obj_index)


## Double object list, instantiate all new object here
# TODO: Instantiate only on-use?
func resize_list() -> PooledObject:
	var old_size = _obj_list.size()
	if old_size >= max_size:
		return

	var new_size = old_size * 2
	if new_size > max_size:
		new_size = max_size

	_obj_list.resize(new_size)

	for i in range(old_size, new_size):
		var obj = packed_scene.instantiate()

		# Do NOT call obj.release here, as it will only take deferred effect
		# and let _free_index empty until after the next frame

		obj._pool_index = i
		obj._object_pool = self
		obj.hide()
		obj.process_mode = Node.PROCESS_MODE_DISABLED

		_obj_list[i] = obj

		_free_idx.push_back(i)

		parent_scene.add_child(_obj_list[i])
	
	return _obj_list[_free_idx.pop_back()].spawn()


## Take on object out of the pool
# Automatically expands pool if it isn't big enough
func pop() -> PooledObject:
	if _free_idx.is_empty():
		return resize_list()
	return _obj_list[_free_idx.pop_back()].spawn()


## Create object pool and fill the first few items
func _init(instantiation_scene: PackedScene, parent_node: Node2D) -> void:
	packed_scene = instantiation_scene
	parent_scene = parent_node

	_obj_list.resize(PoolInitSize)

	for i in range(_obj_list.size()):
		var obj = packed_scene.instantiate()
		obj._pool_index = i
		obj._object_pool = self
		_obj_list[i] = obj
		parent_node.add_child.call_deferred(obj.release())

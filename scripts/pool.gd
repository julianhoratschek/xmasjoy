class_name ObjectPool extends Object


const PoolInitSize := 10

var packed_scene: PackedScene = null
var parent_scene: Node2D = null

var _obj_list: Array[PooledObject] = []
var _free_idx: Array[int] = []


## Should only be called by PooledObject.release()
func _release(obj_index: int):
	_free_idx.push_back(obj_index)


func resize_list() -> PooledObject:
	var old_size = _obj_list.size()

	_obj_list.resize(_obj_list.size() * 2)

	for i in range(old_size, _obj_list.size()):
		var obj = packed_scene.instantiate()
		obj._pool_index = i
		obj._object_pool = self
		obj.hide()
		obj.process_mode = Node.PROCESS_MODE_DISABLED

		_obj_list[i] = obj

		_free_idx.push_back(i)

		parent_scene.add_child(_obj_list[i])
	
	return _obj_list[_free_idx.pop_back()].spawn()


func pop() -> PooledObject:
	if _free_idx.is_empty():
		return resize_list()
	return _obj_list[_free_idx.pop_back()].spawn()


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

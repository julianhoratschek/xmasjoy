class_name ObjectPool extends Object


const PoolInitSize := 10

var packed_scene: PackedScene = null
var parent_scene: Node2D = null

var _obj_list: Array[PooledObject] = []
var _free_idx: Array[int] = []


func resize_list() -> PooledObject:
	var old_size = _obj_list.size()

	_obj_list.resize(_obj_list.size() * 2)

	for i in range(old_size, _obj_list.size()):
		_obj_list[i] = packed_scene.instantiate()

		parent_scene.add_child(
			_obj_list[i].release())

	return _obj_list[old_size].spawn()


func pop() -> PooledObject:
	for obj in _obj_list:
		if obj.process_mode == Node.PROCESS_MODE_DISABLED:
			return obj.spawn()
	return resize_list()


func _init(instantiation_scene: PackedScene, parent_node: Node2D) -> void:
	packed_scene = instantiation_scene
	parent_scene = parent_node

	_obj_list.resize(PoolInitSize)

	for i in range(_obj_list.size()):
		_obj_list[i] = packed_scene.instantiate()
		parent_node.add_child.call_deferred(_obj_list[i].release())

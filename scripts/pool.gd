class_name ObjectPool extends Object

# static var MainScene: Node2D = null
#
# const PoolInitSize := 10
#
# var packed_scene: PackedScene = null
#
# var _obj_list: Array[Node2D] = []
#
#
# func _hide_node(obj: Node2D) -> Node2D:
# 	obj.hide()
# 	obj.process_mode = Node.PROCESS_MODE_DISABLED
# 	return obj
#
#
# func _show_node(obj: Node2D) -> Node2D:
# 	obj.show()
# 	obj.process_mode = Node.PROCESS_MODE_INHERIT
# 	return obj
#
#
# func resize_list() -> Node2D:
# 	var old_size = _obj_list.size()
#
# 	_obj_list.resize(_obj_list.size() * 2)
#
# 	for i in range(old_size, _obj_list.size()):
# 		_obj_list[i] = packed_scene.instantiate()
#
# 		MainScene.add_child(
# 			_hide_node(_obj_list[i]))
#
# 	return _show_node(_obj_list[old_size])
#
#
# func pop() -> Node2D:
# 	for obj in _obj_list:
# 		if !obj.visible:
# 			return _show_node(obj)
# 	return resize_list()
#
#
# func release(obj: Node2D):
# 	_hide_node(obj)
#
#
# func _init(instantiation_scene: PackedScene) -> void:
# 	packed_scene = instantiation_scene
#
# 	_obj_list.resize(PoolInitSize)
#
# 	for obj in _obj_list:
# 		obj = packed_scene.instantiate()
# 		MainScene.add_child(_hide_node(obj))

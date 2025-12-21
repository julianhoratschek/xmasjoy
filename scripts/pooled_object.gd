class_name PooledObject extends Node2D

var _object_pool: ObjectPool = null
var _pool_index := 0

func _do_release():
	if !visible:
		return
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	_object_pool._release(_pool_index)


func release() -> PooledObject:
	_do_release.call_deferred()
	return self


func spawn() -> PooledObject:
	_on_spawn()
	process_mode = Node.PROCESS_MODE_INHERIT
	show()
	return self


func _on_spawn():
	pass

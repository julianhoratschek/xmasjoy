class_name PooledObject extends Node2D


func _do_release():
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED


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

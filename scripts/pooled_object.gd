class_name PooledObject extends Node2D


"""
Base class for all objects used with ObjectPool
Holds a reference to its pool and its index-ID
"""

## Reference to parent ObjectPool
var _object_pool: ObjectPool = null

## Index of self in ObjectPool
var _pool_index := 0


## Deferred release-call, calls _object_pool._release
func _do_release():
	if !visible:
		return
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	_object_pool._release(_pool_index)


## Release this object and put it back into its pool
func release() -> PooledObject:
	_do_release.call_deferred()
	return self


## Take this object out of its pool and activate it
func spawn() -> PooledObject:
	_on_spawn()
	process_mode = Node.PROCESS_MODE_INHERIT
	show()
	return self


## Virtual method
# Override to define behaviour on re-entering object
func _on_spawn():
	pass

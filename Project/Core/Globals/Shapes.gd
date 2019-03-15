extends Node

func get_rect_shape_vertices(collision_shape, offset) :
	var extents : Vector2 = collision_shape.get_shape().get_extents()
	var tl = Vector2(collision_shape.position.x - extents.x, collision_shape.position.y - extents.y)
	var bl = Vector2(collision_shape.position.x - extents.x, collision_shape.position.y + extents.y)
	var tr = Vector2(collision_shape.position.x + extents.x, collision_shape.position.y - extents.y)
	var br = Vector2(collision_shape.position.x + extents.x, collision_shape.position.y + extents.y)
	return [tl+offset, bl+offset, tr+offset, br+offset]
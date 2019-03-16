extends Node2D


var colliding_with_floor = false
var colliding_with_wall = 0

var collision_flags = 0
const TOP = 0x01
const BOTTOM = 0x02
const LEFT = 0x04
const RIGHT = 0x08


#
# Variant collide_and_get_contacts( Transform2D local_xform, Shape2D with_shape, Transform2D shape_xform )
# Return a list of the points where this shape touches another. If there are no collisions, the list is empty.
# This method needs the transformation matrix for this shape (local_xform), the shape to check collisions with (with_shape), and the transformation matrix of that shape (shape_xform).
func handle_tile_collision(context, world_collider, tile_map : TileMap) :
	var world_pos = Nodes.get_space_global_position(world_collider, Globals.world)
	var world_verts = Shapes.get_rect_shape_vertices(world_collider.collision_shape, world_pos)		
	# tl, bl, tr, br
	
	# Adjust collision
	
	if sign(context.velocity.y) == -1  :
		if (TileMaps.check_tile_collide_at_points(tile_map, [world_verts[0], world_verts[2]]) ||
			TileMaps.check_tile_collide_at_points(tile_map, [world_verts[0], world_verts[0] + Vectors.ONE_X*4]) ||
			TileMaps.check_tile_collide_at_points(tile_map, [world_verts[2], world_verts[2] - Vectors.ONE_X*4])) :
				var bbox_top = int(world_verts[0].y)	
				context.position.y = context.position.y + TileMaps.TILE_SIZE - (bbox_top % TileMaps.TILE_SIZE)
												
	if sign(context.velocity.y) == 1  :
		var wv_1 = world_verts[1]
		var wv_3 = world_verts[3]
		if (TileMaps.check_tile_collide_at_points(tile_map, [wv_1, wv_3]) ||
			TileMaps.check_tile_collide_at_points(tile_map, [wv_1, wv_1 + Vectors.ONE_X*4]) ||
			TileMaps.check_tile_collide_at_points(tile_map, [wv_3, wv_3 - Vectors.ONE_X*4])) :
				var bbox_bottom = int(world_verts[1].y)		
				context.position.y = context.position.y - (bbox_bottom % TileMaps.TILE_SIZE)

	if sign(context.velocity.x) == -1 :
		if (TileMaps.check_tile_collide_at_points(tile_map, [world_verts[0], world_verts[1]]) ||
			TileMaps.check_tile_collide_at_points(tile_map, [world_verts[0], world_verts[0] + Vectors.ONE_Y*4]) ||
			TileMaps.check_tile_collide_at_points(tile_map, [world_verts[1], world_verts[1] - Vectors.ONE_Y*4]) ||
			# midpoint
			TileMaps.check_tile_collide_at_points(tile_map, [Vectors.midpoint(world_verts[0], world_verts[1])]) ) :
				var bbox_left = int(world_verts[0].x)
				context.position.x = context.position.x + TileMaps.TILE_SIZE-(bbox_left% TileMaps.TILE_SIZE)
				context.velocity.x = 0	
				
	if sign(context.velocity.x) == 1 :	
		if (TileMaps.check_tile_collide_at_points(tile_map, [world_verts[2], world_verts[3]]) ||
			TileMaps.check_tile_collide_at_points(tile_map, [world_verts[2], world_verts[2] + Vectors.ONE_Y*4]) ||
			TileMaps.check_tile_collide_at_points(tile_map, [world_verts[3], world_verts[3] - Vectors.ONE_Y*4]) ||
			# midpoint
			TileMaps.check_tile_collide_at_points(tile_map, [Vectors.midpoint(world_verts[2], world_verts[3])])) :
				var bbox_right = int(world_verts[2].x)
				context.position.x = context.position.x - (bbox_right % TileMaps.TILE_SIZE) 
				context.velocity.x = 0				
	
	# Check collision
	
	var a = world_verts[0] - Vectors.ONE_Y
	var b = world_verts[2] - Vectors.ONE_Y
	if (TileMaps.check_tile_collide_at_points(tile_map, [a, b]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [a, a + Vectors.ONE_X*4]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [b, b - Vectors.ONE_X*4])) :
			context.velocity.y = 0
			collision_flags |= TOP
	else :
			collision_flags &= ~TOP
	
	a = world_verts[1] + Vectors.ONE_Y
	b = world_verts[3] + Vectors.ONE_Y
	if  (TileMaps.check_tile_collide_at_points(tile_map, [a, b]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [a, a + Vectors.ONE_X*4]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [b, b - Vectors.ONE_X*4])) :
			context.velocity.y = 0
			collision_flags |= BOTTOM
	else :
			collision_flags &= ~BOTTOM
		
	a = world_verts[0] - Vectors.ONE_X
	b = world_verts[1] - Vectors.ONE_X
	if (TileMaps.check_tile_collide_at_points(tile_map, [world_verts[0], world_verts[1]]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [world_verts[0], world_verts[0] + Vectors.ONE_Y*4]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [world_verts[1], world_verts[1] - Vectors.ONE_Y*4]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [Vectors.midpoint(world_verts[0], world_verts[1])]) ) :
			context.velocity.x = 0
			collision_flags |= LEFT
	else :
			collision_flags &= ~LEFT
				
	a = world_verts[2] + Vectors.ONE_X
	b = world_verts[3] + Vectors.ONE_X			
	if (TileMaps.check_tile_collide_at_points(tile_map, [a, b]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [a, a + Vectors.ONE_Y*4]) ||
		TileMaps.check_tile_collide_at_points(tile_map, [b, b - Vectors.ONE_Y*4]) ||
		# midpoint
		TileMaps.check_tile_collide_at_points(tile_map, [Vectors.midpoint(a, b)])) :
			context.velocity.x = 0
			collision_flags |= RIGHT
	else :
			collision_flags &= ~RIGHT
	

					
# Must be called after handle_tile_collision
func handle_check_floor_collision():	
	print(collision_flags)
	print(collision_flags & BOTTOM == BOTTOM)
	return (collision_flags & BOTTOM == BOTTOM)

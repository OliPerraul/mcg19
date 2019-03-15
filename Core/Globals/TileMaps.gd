extends Node

const TILE_SIZE = 32


func tile_collide_at_point(tilemap, point) :
	var map_pt = tilemap.world_to_map(point)
	var tile_idx = tilemap.get_cell(map_pt.x, map_pt.y)
	return tile_idx

func check_tile_collide_at_points(tilemap, points):
	for point in points :
		var t_idx = tile_collide_at_point(tilemap, point) 
		if t_idx == -1 :
			return false	
	return true		

#
#get_world_tile_map():
#	return Globals.world.tile_map
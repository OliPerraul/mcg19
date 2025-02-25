extends Node2D

export(float) var SPEED = 100.0

enum STATES { IDLE, FOLLOW }
var _state = null

var path = []
var target_point_world = Vector2()
var target_position = Vector2()

var velocity = Vector2()


export(float) onready var ARRIVE_DISTANCE = 10


func _ready():
	_change_state(STATES.IDLE)
	_ready2()


func _change_state(new_state):
	if new_state == STATES.FOLLOW:
		path = get_navig_path(global_position, target_position)
		if not path or len(path) == 1:
			_change_state(STATES.IDLE)
			return
		# The index 0 is the starting cell
		# we don't want the character to move back to it in this example
		target_point_world = path[1]
	_state = new_state


func _process(delta):
	if not _state == STATES.FOLLOW:
		return
	var arrived_to_next_point = _move_to(target_point_world)
	if arrived_to_next_point:
		path.remove(0)
		if len(path) == 0:
			_change_state(STATES.IDLE)
			return
		target_point_world = path[0]


func move_to(world_position):
	target_position = world_position
	_change_state(STATES.FOLLOW)


func _move_to(world_position):
	var MASS = 10.0

	var desired_velocity = (world_position - global_position).normalized() * SPEED
	var steering = desired_velocity - velocity
	velocity += steering / MASS
	global_position += velocity * get_process_delta_time()
	#rotation = velocity.angle()
	return global_position.distance_to(world_position) < ARRIVE_DISTANCE


#########
#########
#########

var _point_path = []


# The path start and end variables use setter methods
# You can find them at the bottom of the script
var path_start_position = Vector2() setget _set_path_start_position
var path_end_position = Vector2() setget _set_path_end_position


const BASE_LINE_WIDTH = 3.0
const DRAW_COLOR = Color('#fff')

# get_used_cells_by_id is a method from the TileMap node


func get_navig_path(world_start, world_end):
	var v = Globals.game.tm_solids.to_local(world_start)
	self.path_start_position = Globals.game.tm_solids.world_to_map(Globals.game.tm_solids.to_local(world_start))
	self.path_end_position = Globals.game.tm_solids.world_to_map(Globals.game.tm_solids.to_local(world_end))
	_recalculate_path()
	var path_world = []
	for point in _point_path:
		var point_world = Globals.game.tm_solids.map_to_world(Vector2(point.x, point.y)) + Globals.game.tm_solids.half_cell_size
		path_world.append(point_world)
	return path_world


func _recalculate_path():
	clear_previous_path_drawing()
	var start_point_index = calculate_point_index(path_start_position)
	var end_point_index = calculate_point_index(path_end_position)
	# This method gives us an array of points. Note you need the start and end
	# points' indices as input
	_point_path = astar_node.get_point_path(start_point_index, end_point_index)
	# Redraw the lines and circles from the start to the end point
	update()


func clear_previous_path_drawing():
	if not _point_path:
		return
	var point_start = _point_path[0]
	var point_end = _point_path[len(_point_path) - 1]


func _draw():
	if not _point_path:
		return
	var point_start = _point_path[0]
	var point_end = _point_path[len(_point_path) - 1]

	var last_point = (Globals.game.tm_solids.map_to_world(Vector2(point_start.x, point_start.y)) + Globals.game.tm_solids.half_cell_size)
	
	for index in range(1, len(_point_path)):
		var current_point = (Globals.game.tm_solids.map_to_world(Vector2(_point_path[index].x, _point_path[index].y)) + Globals.game.tm_solids.half_cell_size)
		draw_segment(last_point, current_point)
		last_point = current_point

func draw_segment(last_point, current_point):
		draw_line(last_point, current_point, DRAW_COLOR, BASE_LINE_WIDTH, true)
		draw_circle(current_point, BASE_LINE_WIDTH * 2.0, DRAW_COLOR)

# Setters for the start and end path values.
func _set_path_start_position(value):
	if value in obstacles:
		return
	if is_outside_map_bounds(value):
		return

	path_start_position = value
	if path_end_position and path_end_position != path_start_position:
		_recalculate_path()


func _set_path_end_position(value):
	if value in obstacles:
		return
	if is_outside_map_bounds(value):
		return

	path_end_position = value
	if path_start_position != value:
		_recalculate_path()
		
		
		


################
###############

# You can only create an AStar node from code, not from the Scene tab
onready var astar_node = AStar.new()

# The Tilemap node doesn't have clear bounds so we're defining the map's limits here
export(Vector2) var map_size = Vector2(32, 32)

# The path start and end variables use setter methods
# You can find them at the bottom of the script

#const BASE_LINE_WIDTH = 3.0
#const DRAW_COLOR = Color('#fff')

# get_used_cells_by_id is a method from the TileMap node
# here the id 0 corresponds to the grey tile, the obstacles
var obstacles
var half_cell_size


func _ready2():
	obstacles = Globals.game.tm_solids.get_used_cells_by_id(0)
	half_cell_size = Globals.game.tm_solids.cell_size / 2
	var walkable_cells_list = astar_add_walkable_cells(obstacles)
	astar_connect_walkable_cells_diagonal(walkable_cells_list)


# Click and Shift force the start and end position of the path to update
# and the node to redraw everything
#func _input(event):
#	if event.is_action_pressed('click') and Input.is_key_pressed(KEY_SHIFT):
#		# To call the setter method from this script we have to use the explicit self.
#		self.path_start_position = world_to_map(get_global_mouse_position())
#	elif event.is_action_pressed('click'):
#		self.path_end_position = world_to_map(get_global_mouse_position())



# Loops through all cells within the map's bounds and
# adds all points to the astar_node, except the obstacles
func astar_add_walkable_cells(obstacles = []):
	var points_array = []
	
	var relcenter = Globals.game.tm_solids.world_to_map(Globals.game.tm_solids.to_local(global_position))
	
	for y in range(relcenter.y + -map_size.y, relcenter.y + map_size.y):
		for x in range(relcenter.x + -map_size.x, relcenter.x + map_size.x):
			var point = Vector2(x, y)
			if point in obstacles:
				continue
				
			points_array.append(point)
			# The AStar class references points with indices
			# Using a function to calculate the index from a point's coordinates
			# ensures we always get the same index with the same input point
			var point_index = calculate_point_index(point)
			# AStar works for both 2d and 3d, so we have to convert the point
			# coordinates from and to Vector3s
			astar_node.add_point(point_index, Vector3(point.x, point.y, 0.0))
	return points_array




# Once you added all points to the AStar node, you've got to connect them
# The points don't have to be on a grid: you can use this class
# to create walkable graphs however you'd like
# It's a little harder to code at first, but works for 2d, 3d,
# orthogonal grids, hex grids, tower defense games...
func astar_connect_walkable_cells(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		# For every cell in the map, we check the one to the top, right.
		# left and bottom of it. If it's in the map and not an obstalce,
		# We connect the current point with it
		var points_relative = PoolVector2Array([
			Vector2(point.x + 1, point.y),
			Vector2(point.x - 1, point.y),
			Vector2(point.x, point.y + 1),
			Vector2(point.x, point.y - 1)])
		for point_relative in points_relative:
			var point_relative_index = calculate_point_index(point_relative)

			if is_outside_map_bounds(point_relative):
				continue
			if not astar_node.has_point(point_relative_index):
				continue
			# Note the 3rd argument. It tells the astar_node that we want the
			# connection to be bilateral: from point A to B and B to A
			# If you set this value to false, it becomes a one-way path
			# As we loop through all points we can set it to false
			astar_node.connect_points(point_index, point_relative_index, false)


# This is a variation of the method above
# It connects cells horizontally, vertically AND diagonally
func astar_connect_walkable_cells_diagonal(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		for local_y in range(3):
			for local_x in range(3):
				var point_relative = Vector2(point.x + local_x - 1, point.y + local_y - 1)
				var point_relative_index = calculate_point_index(point_relative)

				if point_relative == point or is_outside_map_bounds(point_relative):
					continue
				if not astar_node.has_point(point_relative_index):
					continue
				astar_node.connect_points(point_index, point_relative_index, true)



func is_outside_map_bounds(point):
	return point.x < 0 or point.y < 0 or point.x >= map_size.x or point.y >= map_size.y




func calculate_point_index(point):
	return point.x + map_size.x * point.y

		






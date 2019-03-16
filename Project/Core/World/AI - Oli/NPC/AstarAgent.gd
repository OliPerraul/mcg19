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
	self.path_start_position = Globals.game.tm_solids.world_to_map(world_start)
	self.path_end_position = Globals.game.tm_solids.world_to_map(world_end)
	_recalculate_path()
	var path_world = []
	for point in _point_path:
		var point_world = Globals.game.tm_solids.map_to_world(Vector2(point.x, point.y)) + Globals.game.tm_solids.half_cell_size
		path_world.append(point_world)
	return path_world


func _recalculate_path():
	clear_previous_path_drawing()
	var start_point_index = Globals.game.tm_solids.calculate_point_index(path_start_position)
	var end_point_index = Globals.game.tm_solids.calculate_point_index(path_end_position)
	# This method gives us an array of points. Note you need the start and end
	# points' indices as input
	_point_path = Globals.game.tm_solids.astar_node.get_point_path(start_point_index, end_point_index)
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
	if value in Globals.game.tm_solids.obstacles:
		return
	if Globals.game.tm_solids.is_outside_map_bounds(value):
		return

	path_start_position = value
	if path_end_position and path_end_position != path_start_position:
		_recalculate_path()


func _set_path_end_position(value):
	if value in Globals.game.tm_solids.obstacles:
		return
	if Globals.game.tm_solids.is_outside_map_bounds(value):
		return

	path_end_position = value
	if path_start_position != value:
		_recalculate_path()


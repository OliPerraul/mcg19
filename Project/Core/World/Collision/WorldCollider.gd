extends Area2D

signal collided_with_wall


export(NodePath) onready var tile_map_collision_helper
export(NodePath) onready var collision_shape


func _ready():
	tile_map_collision_helper = get_node(tile_map_collision_helper)
	collision_shape = get_node(collision_shape)
	
	tile_map_collision_helper.connect('collided_with_wall', self, '_on_collided_with_wall')
	
	

func handle_update(context):
	# TODO : Other solids than tiles
	# TODO : Find a way to do this only if necessary
	tile_map_collision_helper.handle_tile_collision(context, self, Globals.world.tile_map)
	

func check_floor_collision() :
	# TODO other solids than tiles
	return tile_map_collision_helper.handle_check_floor_collision()



func _on_collided_with_wall() :
	# TODO other solids than tiles
	emit_signal('collided_with_wall')


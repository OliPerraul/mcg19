extends PathFollow2D

export(float) onready var _speed = 100

export(NodePath) onready var __path
var path

var tween


func reset(character):
	offset = path.curve.get_closest_offset(character.global_position)

func _ready():
	path = get_parent()
	set_process(true)
	

func _process(delta):
	#follow.set_offset(follow.get_offset() + 350 * delta)
	offset = offset + _speed * delta;
	
	
func get_closest_point(character):
	return path.to_global(path.curve.get_closest_point(character.global_position))

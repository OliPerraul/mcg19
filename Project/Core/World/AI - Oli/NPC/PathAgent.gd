extends PathFollow2D

export(float) onready var _speed = 100

export(NodePath) onready var __path
var _path

var tween


func reset():
	offset = 0

func _ready():
	_path = get_node(__path)
	set_process(true)
	

func _process(delta):
	#follow.set_offset(follow.get_offset() + 350 * delta)
	offset = offset + _speed * delta;
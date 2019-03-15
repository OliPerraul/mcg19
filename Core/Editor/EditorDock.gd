extends WindowDialog


export(NodePath) onready var __context_menu
var _context_menu 

var _start_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_pos = get_position()
	show()



func _process(delta):
	pass #set_position(_start_pos)

extends JASON_GOALDIR

export(NodePath) onready var __cam
export(NodePath) onready var __obj


# Called when the node enters the scene tree for the first time.
func _ready():
	self.init(get_node(__obj), get_node(__cam))
	z_index = -1	

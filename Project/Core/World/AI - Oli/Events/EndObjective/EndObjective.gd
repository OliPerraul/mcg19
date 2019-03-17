extends OLI_EVENT

export(int) onready var score = 10

export(NodePath) onready var __sprite
var sprite :Sprite

var start_timer = false
var time_trash_dissap = 0
export(float) onready var time_trash_dissap_lim = 4

var time
var dial

func _ready():
	sprite = get_node(__sprite)

# OVERRIDE
				
func _on_body_stay(b):
	if Input.is_action_just_released("ui_accept") && sprite.frame == 0:
		Globals.game.wingame()

		


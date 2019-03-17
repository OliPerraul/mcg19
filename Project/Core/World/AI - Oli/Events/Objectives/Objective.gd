extends OLI_EVENT

export(float) onready var score = 10

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
func handle(player):
	if player.is_in_group("detectable"):
		player.Objective(self)
		
				
func _on_body_stay(b):
	if Input.is_action_just_released("ui_accept") && sprite.frame == 0:
		sprite.frame = 1
		Globals.score += score
		start_timer = true

		
func _process(delta):
	if start_timer :
		time_trash_dissap+= delta
		if time_trash_dissap >= time_trash_dissap_lim:
			Globals.game.goals.remove(self)
		

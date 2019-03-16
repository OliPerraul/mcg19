extends Node2D


func _process(delta):
	pass

export(float) onready var priority
onready var type = Globals.DETECTABLE.PLAYER


func _input(event):
	if event.is_action_pressed('click'):
		transform.origin = get_global_mouse_position()
				

func _ready():
	add_to_group("detectable")
#	direction_from_player = (get_position() - Globals.game.player.get_position()).normalized()
#	direction = direction_from_player
#	pos = get_position()





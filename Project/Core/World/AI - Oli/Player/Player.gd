extends Node2D

var pos = Vector2()
var direction_from_player = Vector2()
var direction = Vector2()


func _process(delta):
	pass


func _input(event):
	if event.is_action_pressed('click'):
		transform.origin = get_global_mouse_position()
				

func _ready():
	direction_from_player = (get_position() - Globals.game.player.get_position()).normalized()
	direction = direction_from_player
	pos = get_position()

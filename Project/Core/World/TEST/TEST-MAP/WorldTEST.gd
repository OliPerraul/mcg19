extends Node2D

export (NodePath) var goal

func _ready():
	pass

func _on_StartTimer_timeout():
	$EventManager.camera_cinematic(get_node(goal).position, 1, 2.5, true)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			print("lock")
			$Middleground/Player._player_lock()
		else:
			print("unlock")
			$Middleground/Player._player_unlock()
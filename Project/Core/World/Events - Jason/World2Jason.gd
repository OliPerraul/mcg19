extends Node2D

export (NodePath) var goal

func _on_StartTimer_timeout():
	$EventManager.camera_cinematic(get_node(goal).global_position, 1, 2.5, true)
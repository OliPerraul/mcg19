extends Node2D

var goal

func _on_StartTimer_timeout():
	$EventManager.camera_cinematic(goal.global_position, 1, 2.5, true)
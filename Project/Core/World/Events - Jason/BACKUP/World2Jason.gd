extends Node2D

export (NodePath) var goal
var GoalDirection = preload("res://Core/World/Events - Jason/GoalDirection.tscn")

func _ready():
	var dial = GoalDirection.instance()
	dial.init($GOALS/Position2D, $Middleground/Player/Camera2D)
	$CanvasLayer.add_child(dial)

func _on_StartTimer_timeout():
	$EventManager.camera_cinematic(get_node(goal).position, 1, 2.5, true)
extends Node

export(NodePath) onready var __controller
var _controller

export(NodePath) onready var __hit_box
var _hit_box

export(NodePath) onready var __collision_box
var _collision_box


func _ready():
	_controller = get_node(__controller)
	_hit_box = get_node(__hit_box)
	_collision_box = get_node(__collision_box)


	



func _on_left_obstacle():
	_controller.set_target_horizontal(1)	
	
	
func _on_right_obstacle():
	_controller.set_target_horizontal(-1)

	
	

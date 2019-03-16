extends Node2D

export(float) onready var lerp_speed = .5

var alert = 0

export(NodePath) onready var __astar_agent
var astar_agent

export(NodePath) onready var __path_agent
var path_agent


export(NodePath) onready var __vision
var vision


export(NodePath) onready var __fsm
var _fsm


var direction = Vector2(0, 1)
var last_position = Vector2()



# Called when the node enters the scene tree for the first time.
func _ready():
	astar_agent = get_node(__astar_agent)
	vision = get_node(__vision)
	path_agent = get_node(__path_agent)
	_fsm = get_node(__fsm)	
	

extends Node2D

export(float) onready var lerp_speed = .02

var alert = 0

export(NodePath) onready var __astar_agent
var astar_agent

export(NodePath) onready var __path_agent
var path_agent


export(NodePath) onready var __vision
var vision


export(NodePath) onready var __fsm
var fsm


onready var direction = Vector2(0, 1)
onready var last_position = Vector2()



# Called when the node enters the scene tree for the first time.
func _ready():
	astar_agent = get_node(__astar_agent)
	vision = get_node(__vision)
	path_agent = get_node(__path_agent)
	fsm = get_node(__fsm)	
	

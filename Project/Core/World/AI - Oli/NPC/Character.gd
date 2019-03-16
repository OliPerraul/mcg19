extends Node2D

export(float) onready var lerp_speed = .02

var alert = 0

export(NodePath) onready var __astar_agent
var astar_agent

export(NodePath) onready var __path_agent
var path_agent


export(NodePath) onready var __vision
var vision


export(NodePath) onready var __animator
var animator : AnimatedSprite

export(NodePath) onready var __emoji
var emoji : AnimatedSprite


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
	animator = get_node(__animator)
	
	emoji = get_node(__emoji)
	

func _process(delta):
	if sign(direction.y) == 1 :
		animator.play('Front')
	elif sign(direction.y) == -1:
		animator.play('Back')
	else:
		animator.play('Front')
		
	# left right overrides		
	if abs(direction.x) >= 1:	
		if sign(direction.x) == -1 :
			animator.play('Left')
		elif sign(direction.x) == 1:
			animator.play('Right')
		else:
			animator.play('Front')
			
		
		
	

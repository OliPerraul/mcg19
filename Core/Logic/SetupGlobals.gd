extends Node

export(NodePath) onready var __canvas_layer
export(NodePath) onready var __world
export(NodePath) onready var __hud
export(NodePath) onready var __game
export(NodePath) onready var __output


# TODO remove autoload


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.canvas_layer = get_node(__canvas_layer)
	Globals.world = get_node(__world)
	Globals.hud = get_node(__hud)
	Globals.game = get_node(__game)
	
	System._output = get_node(__output)
	
	
	
	
	
	
	
	
	
	
	# Nodes.dummy_control = get_node(__dummy_control)	
	# Destroy after initialization
	queue_free()
	

extends Node

export(NodePath) onready var __tm_solids
onready var tm_solids

export(NodePath) onready var __player
onready var player


func _ready():
	tm_solids = get_node(__tm_solids)
	player = get_node(__player)
	Globals.game = self
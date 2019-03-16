extends Node

export(NodePath) onready var __tm_solids
onready var tm_solids

func _ready():
	tm_solids = get_node(__tm_solids)
	Globals.game = self
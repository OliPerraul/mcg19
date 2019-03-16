extends Area2D


export(NodePath) onready var __context
var context

func _ready():
	context = get_node(__context)




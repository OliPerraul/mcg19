extends Node


export(NodePath) onready var __play
export(NodePath) onready var __howto
export(NodePath) onready var __popup


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(__play).connect('pressed', self, '_on_play')
	get_node(__howto).connect('pressed',self, '_on_howto')
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_play():
	Globals.score = 0
	get_tree().change_scene("res://Core/World/Jack/ThirdWorld.tscn")

func _on_howto():
	print('howto')
	get_node(__popup).popup()



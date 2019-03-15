extends Node

export(NodePath) onready var __close_button
var _close_button


export(NodePath) onready var __margin_container
var _margin_container


var _resource_editor


func setup(editor : Control):
	_close_button = get_node(__close_button)
	_margin_container = get_node(__margin_container)
	_close_button.connect('pressed', self, 'close')	
	_resource_editor = editor
	_margin_container.add_child(_resource_editor)
	Globals.hud.register_children_focus_from(editor)
	
	
	Nodes.control_make_full_rect(editor)
	_close_button.raise()
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func close():
	queue_free()

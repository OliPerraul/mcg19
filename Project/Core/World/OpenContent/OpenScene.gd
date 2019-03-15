extends Node2D


export(NodePath) onready var __open_node
var _open_node

export(NodePath) onready var __scn_editor
var _scn_editor


var _processing_hit_box_clicked = false


func _ready():
	call_deferred('_post_ready')
	
func _post_ready():
	_open_node = get_node(__open_node)
	_scn_editor = get_node(__scn_editor)
	_scn_editor.connect('query_attach_script', self, 'attach_script')
	_scn_editor.setup(_open_node)
	_open_node.hit_box.connect('input_event', self, '_on_hit_box_clicked')

		
func _on_hit_box_clicked(viewport, event, shape_idx):
	if Input.is_action_just_released('ui_mb_any') :
		if not _processing_hit_box_clicked :	
			_processing_hit_box_clicked = true
			_scn_editor.open()
			_processing_hit_box_clicked = false
		







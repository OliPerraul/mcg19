extends Control

export(NodePath) onready var __text_edit
var _text_edit : TextEdit

export(NodePath) onready var __output
var _output

func _ready():
	_text_edit = get_node(__text_edit)
	#set_process_input(true)
	#text_edit = get_text_edit()




func _process(delta):
	pass
#	if Input.is_action_pressed("ui_console_lock"):
#		self._lock()
#	elif Input.is_action_just_released("ui_console_lock"):
#		self._unlock()
	


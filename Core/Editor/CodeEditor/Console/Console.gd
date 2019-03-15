
extends 'res://Core/Editor/CodeEditor/CodeEditor.gd'

export(NodePath) onready var __console_helper
var _console_helper : MoMaConsoleHelper


func _ready():
	_output = get_node(__output)
	_console_helper = get_node(__console_helper)
	_console_helper.setup(_text_edit, _output)
	_text_edit.text = Defaults.CONSOLE_TEXT

		
func _input(event):
	if Input.is_action_pressed('ui_ctrl_any') || Input.is_action_just_pressed('ui_ctrl_any') :
		_text_edit.readonly = true
	else : 
		_text_edit.readonly = false
	
	if event.is_action_pressed('ui_textbox_submit'):
		_console_helper.execute()


func output(msg):
	_output.output(msg)
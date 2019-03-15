extends 'res://Core/Editor/CodeEditor/CodeEditor.gd'

func _ready():	
	_text_edit.set_text(Defaults.SCRIPT_TEXT)
	
func set_output(output):
	_output = output
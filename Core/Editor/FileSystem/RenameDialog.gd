extends ConfirmationDialog

signal name_entered

export(NodePath) onready var __line_edit
var _line_edit : LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	_line_edit = get_node(__line_edit)
	connect('confirmed', self, '_on_confirmed')


func setup():
	_line_edit.text = ''
	show()
	raise()
	_line_edit.grab_focus()


func _input(event):
	if Input.is_action_just_released('ui_submit') && visible :
		_on_confirmed()
		_line_edit.release_focus()
		hide()
	
func _on_confirmed():
	emit_signal('name_entered', _line_edit.text)
	hide()


extends Control


func _ready():
	connect('focus_entered', self, '_on_focus_entered')

func _on_focus_entered():
	if visible : 
		call_deferred('hide')

extends Control

signal child_focus_entered
signal child_focus_exited

export(NodePath) onready var __player
var _player

export(NodePath) onready var __controller
var _controller


export(NodePath) onready var __focus_grab
var _focus_grab


func _ready():
	_player = get_node(__player)
	_controller = get_node(__controller)
	_focus_grab = get_node(__focus_grab)
	
	_player.connect('start_moving', self, '_release_all_focus')
	register_children_focus_from(self)	
	connect('child_focus_entered', _controller, 'deactivate')
	connect('child_focus_exited', _controller, 'activate')
	
	
# TODO make global	
func _release_all_focus():
	if get_focus_owner() :
		get_focus_owner().release_focus()
	

func _on_child_focus_entered() :
	emit_signal('child_focus_entered')
	if not _focus_grab.visible :
		_focus_grab.show()
	
func _on_child_focus_exited() :
	emit_signal('child_focus_exited')
	_release_all_focus()


func register_child_focus(child):
	child.set_focus_mode(Control.FOCUS_CLICK)
	child.connect('focus_entered', self, '_on_child_focus_entered')
	child.connect('focus_exited', self, '_on_child_focus_exited')

		
func _recurse_register_children_focus(node):
	for child in node.get_children() :
		if child is Control && not child.is_connected('focus_entered', self, '_on_child_focus_entered'):
			register_child_focus(child)
		_recurse_register_children_focus(child)
	

func register_children_focus_from(node):
	_recurse_register_children_focus(node)



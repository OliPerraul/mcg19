class_name OLI_FSM
extends Node

onready var _states
export(NodePath) onready var __start_state
var _state
export(NodePath) onready var __context
var _context

func _ready():
	_state = get_node(__start_state)
	_context = get_node(__context)
	
	_states = Dictionary()
	#Get other states
	var children = get_children()
	for st in children:
		_states[st.name] = st


func _process(delta):
	_state.update(_context, delta)

func physics_update(delta):
	_state.physics_update(_context, delta)
	
func set_state(new_state, args):
	_state.clean()
	_state = new_state
	new_state.setup(_context, args)

func set_state_named(name_, args):
	set_state(_states[name_], args)
	pass

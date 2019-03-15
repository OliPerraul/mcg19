extends Control

enum RESOURCE_TYPE {
	FOLDER = 0
	SCRIPT = 1,
	SPRITE = 2,
	SCENE = 3
}


export(NodePath) onready var __resource_factory
var _resource_factory

export(NodePath) onready var __context_menu
var _context_menu

export(NodePath) onready var __tree
var _tree

export(NodePath) onready var __folder_explorer
var _folder_explorer

export(int) var _preview_item_max = 10
export(float) var _preview_opacity_max = 1.0
var opacity_step = _preview_opacity_max/_preview_item_max


onready var active_folder
onready var _mouse_pos
onready var _drag_preview


var _start_pos


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred('_post_ready')
	_tree = get_node(__tree)
	_folder_explorer = get_node(__folder_explorer)
	_context_menu = get_node(__context_menu)
	_resource_factory = get_node(__resource_factory)

	_tree.connect("item_edited", self, "_on_tree_item_edited")
	_tree.connect('gui_input', self, '_show_context_menu', [_tree])	
	_folder_explorer.connect('gui_input', self, '_show_context_menu', [null])
	_context_menu.connect('index_pressed', self, '_on_context_menu_action')
	
	active_folder = _resource_factory.create_named(FOLDER, null, '', '')
	_tree.create_resource_item(null, active_folder)	

	
func _process(delta):
	_mouse_pos = get_global_mouse_position()	
	if is_instance_valid(_drag_preview) :
		_drag_preview.set_position(_mouse_pos) 
	
	
func _post_ready():
	Nodes.set_parent(_context_menu, Globals.canvas_layer)

func _populate_tree(idx):
	var res = _resource_factory.create(idx, active_folder.tree_item, active_folder.path)
	_tree.create_resource_item(active_folder.tree_item, res)


func _on_context_menu_action(idx):
	if idx < 3 :
		_populate_tree(idx)
	else:
	# Assume its a function and call it
		var func_ref = _context_menu.get_item_metadata(idx)
		func_ref.call_func()

func _setup_context_menu(sender):
	_context_menu.set_position(get_global_mouse_position())
	_context_menu.clear()
	_context_menu.add_item('New Folder..')
	_context_menu.add_item('New Script..')
	_context_menu.add_item('New Sprite..')
	
	if sender != null :
		sender.populate_context_menu(_context_menu)


func _show_context_menu(event, sender):
	if event is InputEventMouseButton && Input.is_action_just_pressed('ui_mb_right') :
		_setup_context_menu(sender)
		_context_menu.popup()

func change_directory():
	pass
	
	

	
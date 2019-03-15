extends Control

enum RESOURCE_TYPE {
	FOLDER = 0
	SCRIPT = 1,
	SPRITE = 2,
	SCENE = 3
}


export(NodePath) onready var __resource_factory
var _resource_factory


export(NodePath) onready var __folder_explorer_parent
var _folder_explorer_parent

export(NodePath) onready var __folder_explorer
var _folder_explorer


export(PackedScene) onready var _sprite_editor_scn
export(PackedScene) onready var _script_editor_scn
export(PackedScene) onready var _res_editor_par_scn


export(NodePath) onready var __context_menu
var _context_menu


export(NodePath) onready var __editor_tab_destination
var _editor_tab_destination


export(NodePath) onready var __output
var _output


export(int) var _preview_item_max = 10
export(float) var _preview_opacity_max = 1.0
var opacity_step = _preview_opacity_max/_preview_item_max


onready var _mouse_pos
onready var _drag_preview


var _start_pos


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred('_post_ready')
	_folder_explorer_parent = get_node(__folder_explorer_parent)
	_output = get_node(__output)
	_folder_explorer = get_node(__folder_explorer)
	_context_menu = get_node(__context_menu)
	_resource_factory = get_node(__resource_factory)
	_editor_tab_destination = get_node(__editor_tab_destination)
	

	# _tree.connect("item_edited", self, "_on_tree_item_edited")
	_folder_explorer.connect('gui_input', self, '_show_context_menu', [_folder_explorer])
	_context_menu.connect('index_pressed', self, '_on_context_menu_action')
	
	# Create root folder with no corresponding item
	var root_folder = _resource_factory.create_named(FOLDER, null, '')
	_folder_explorer.setup_root_folder(root_folder)	
	
	
func _process(delta):
	_mouse_pos = get_global_mouse_position()	
	if is_instance_valid(_drag_preview) :
		_drag_preview.set_position(_mouse_pos) 
	
	
func _post_ready():
	Nodes.set_parent(_context_menu, Globals.canvas_layer)


func _populate_folder(res_type, folder):
	var res = _resource_factory.create(res_type, folder)
	_folder_explorer.create_resource_item(folder, res)


func _on_context_menu_action(idx):
	if idx < 3 :
		_populate_folder(idx, _folder_explorer.get_destination_folder())
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


# TODO : Prevent player move as newly added ui child

func open_resource(res, editor):
	var editor_par =  _res_editor_par_scn.instance()
	editor_par.setup(editor)	
	var idx = _editor_tab_destination.get_child_count()
	_editor_tab_destination.add_child(editor_par)
	_editor_tab_destination.set_tab_title(idx, res.resname)
	_editor_tab_destination.set_current_tab(idx)
	editor.set_output(_output)


func open_script_resource(script):
	var editor_instance = _script_editor_scn.instance()
	open_resource(script, editor_instance)
	
	
	
func open_sprite_resource(sprite):
	var editor_instance = _sprite_editor_scn.instance()
	open_resource(sprite, editor_instance)

	

	
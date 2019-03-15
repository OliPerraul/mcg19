extends Node


export(NodePath) onready var __tree
var _tree

export(int) var _preview_item_max = 10
export(float) var _preview_opacity_max = 1.0
var opacity_step = _preview_opacity_max/_preview_item_max


onready var _mouse_pos
onready var _drag_preview

# Called when the node enters the scene tree for the first time.
func _ready():
	_tree = get_node(__tree)
	_tree.set_drop_mode_flags(0)
	
#	_tree_dragndrop = MoMaTreeDragnDrop.new()
#	_tree_dragndrop.setup(_tree, active_folder)
	
func _process(delta):
	if is_instance_valid(_drag_preview) :
		_populate_adjusted_mouse_pos()
		_drag_preview.set_position(_mouse_pos) 

func _populate_adjusted_mouse_pos():
		_mouse_pos = Globals.hud.get_global_mouse_position() #Globals.world.get_global_mouse_position()
#		_mouse_pos = parent_ctrl.get_global_mouse_position() + parent_ctrl.get_global_position()
#		_mouse_pos /= parent_ctrl.get_scale()
		#_mouse_pos += parent_ctrl.get_position()*parent_ctrl.get_scale()

func _input(event):
	if Input.is_action_just_released('ui_mb_left'):
		clear_drag_preview()


func clear_drag_preview():
	Memory.safe_queue_free(_drag_preview)

func _setup_drag_preview():
	Nodes.set_parent(_drag_preview, Globals.canvas_layer)	
	_drag_preview.set_as_toplevel(true)
	_populate_adjusted_mouse_pos()
	_drag_preview.set_position(_mouse_pos) # set initial mouse pos
	_drag_preview.set_mouse_filter(_tree.MOUSE_FILTER_IGNORE)
	add_child(_drag_preview) # add as child of viewport
	_drag_preview.raise()
	return

# @override
func handle_get_drag_data(pos, dnd_wrapper_script):
	_tree.set_drop_mode_flags(3)
	var next = _tree.get_next_selected(null)
	var selected = Array()
	clear_drag_preview()
	_drag_preview = VBoxContainer.new() # drag data preview
	var opacity_item = _preview_opacity_max
	while next :
		var md = next.get_metadata(0)		
		selected.append(md)	
		# Build the drag preview
		var hb = _tree.create_selection_item_preview(next)
		hb.set_modulate(Color(1, 1, 1, opacity_item))		
		hb.set_mouse_filter(_tree.MOUSE_FILTER_IGNORE)
		_drag_preview.add_child(hb)		
		opacity_item -= opacity_step
		next = _tree.get_next_selected(next)

	if selected.empty():
		return null
	else:
		_setup_drag_preview()
		var dnd_wrapper = dnd_wrapper_script.new()		
		dnd_wrapper.data = selected
		return dnd_wrapper

	
	
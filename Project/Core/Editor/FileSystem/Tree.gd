extends Tree

export(Script) onready var _dnd_wrap_script
export(NodePath) onready var __dragndrop_behaviour
var _dragndrop_behaviour
var _selected = null


# Called when the node enters the scene tree for the first time.
func _ready():
	_dragndrop_behaviour = get_node(__dragndrop_behaviour)
	

func _gui_input(event):
	if event is InputEventMouseButton && Input.is_action_just_pressed('ui_mb_any') :
		_selected = get_selected() 
		if is_instance_valid(_selected) :
			if get_item_at_position(get_local_mouse_position()) != _selected :
				_selected.deselect(0)
				_selected = null
				return

			
func populate_context_menu(context_menu : PopupMenu):
	if _selected != null :
		context_menu.add_separator()
		context_menu.add_item('Copy', 1)		
		context_menu.set_item_metadata(context_menu.get_item_index(1), funcref(self, 'copy_resource'))		
		
		context_menu.add_item('Duplicate', 2)
		context_menu.set_item_metadata(context_menu.get_item_index(2), funcref(self, 'duplicate_resource'))
#
#		context_menu.add_item('Rename', 3)
#		context_menu.set_item_metadata(context_menu.get_item_index(3), funcref(self, 'rename_resource'))		
		
		context_menu.add_item('Delete', 4)	
		context_menu.set_item_metadata(context_menu.get_item_index(4), funcref(self, 'delete_resource'))	
		
	else :
		# Reset context menu size
		context_menu.rect_size = get_minimum_size()
	
	
func copy_resource():
	print('copy res')
	
func duplicate_resource():
	print('dupe res')	
	
	
func delete_resource():
	print('del res')
		

# Create root folder and corresponding item
func setup_root_folder(root_folder):
	create_resource_item(null, root_folder)	# create invisible resource item

	
func create_resource_item(parent_item, resource):
	var item = create_item(parent_item, 0)
	resource.configure_tree_item(item)
	item.set_editable(0, true)
	item.set_metadata(0, resource)	
	item.set_tooltip(0, resource.path)
	item.set_text(0, resource.resname)
	item.set_selectable(0, true)


# @override
func get_drag_data(pos):
	return _dragndrop_behaviour.handle_get_drag_data(pos, _dnd_wrap_script)
	

# @override
func can_drop_data(pos, data):
	return _dragndrop_behaviour.handle_can_drop_data(pos, data)
	
	
# @override
func drop_data(pos, data):
	_dragndrop_behaviour.handle_drop_data(pos, data)
	
	
# @impl
func create_selection_item_preview(item):
	var md = item.get_metadata(0)
	var hb = HBoxContainer.new()
	var tf = TextureRect.new()
	tf.set_texture(md.icon)
	hb.add_child(tf);
	var label = Label.new()
	label.set_text(md.resname)
	hb.add_child(label)	
	return hb
	
	

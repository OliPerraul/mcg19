extends ItemList

enum RESOURCE_TYPE {
	FOLDER = 0
	SCRIPT = 1,
	SPRITE = 2,
	SCENE = 3
}

export(Script) onready var _dnd_wrap_script
export(NodePath) onready var __dragndrop_behaviour
var _dragndrop_behaviour

export(NodePath) onready var __file_system
var _file_system


export(NodePath) onready var __rename_dialog
var _rename_dialog


var _selected_indices = null

var _active_folder
var _selected_folder = null


# Called when the node enters the scene tree for the first time.
func _ready():
	_file_system = get_node(__file_system)
	_rename_dialog = get_node(__rename_dialog)
	_dragndrop_behaviour = get_node(__dragndrop_behaviour)
	set_focus_mode(FOCUS_CLICK)
	_rename_dialog.connect('name_entered', self, '_on_name_entered') # never single selected		
	connect('multi_selected', self, '_on_multi_selected') # never single selected
	connect('nothing_selected', self, '_clear_selected')
	connect('item_activated', self, '_on_item_activated')



func move_resources(resources, folder):
	for res in resources :
		res.folder.content.erase(res)
		folder.content.append(res)
	# refresh
	refresh()


func _is_backtrack_item(idx) :
	return idx == 0 && _active_folder.folder


func move_resource(resource, folder):
	move_resources([resource], folder)

	
func change_active_folder(folder):
	clear()
	_active_folder = folder
	if folder.folder :
		create_backtrack_item()	
	for resource in folder.content :
		create_resource_item(folder, resource)			

func refresh():
	change_active_folder(_active_folder)

	
func _on_item_activated(idx):
	if _active_folder.folder : # if not root folder and first item, perform backtrack
		if _is_backtrack_item(idx) :
				change_active_folder(_active_folder.folder)	
				return
	var resource = get_item_metadata(idx)
		
	if resource.is_folder() :
		change_active_folder(resource)	
	else:
		resource.handle_activated_by_file_system(_file_system)
	

func _on_multi_selected(idx, are_selected):
	_selected_indices = get_selected_items()
	for idx in _selected_indices :
		if get_item_metadata(idx) && get_item_metadata(idx).is_folder() :
			_selected_folder = get_item_metadata(idx)
			return
	_selected_folder = null	
		
	
func _clear_selected() :
	unselect_all()
	_selected_indices = null
	_selected_folder = null	
	

func setup_root_folder(root_folder):
	_active_folder = root_folder
	#_folder_explorer.create_resource_item(null, active_folder)		


func get_destination_folder():
	if _selected_folder :
		return _selected_folder
	return _active_folder 


func get_item_position(idx):
	var icon_size = get_item_icon(idx).get_size()
	var item_size = Vector2(fixed_column_width, icon_size.y)
	var size = rect_size
	var x = int(idx) * int(item_size.x)
	if x % int(size.x) < x :
		x = 0
	 
	var y = (int(idx) / int(size.x) ) * item_size.y
	return Vector2(x,y)
	

			
func populate_context_menu(context_menu : PopupMenu):
	if _selected_indices && len(_selected_indices) > 0 :
		context_menu.add_separator()
		
		var idx = context_menu.get_item_count()
		
		context_menu.add_item('Copy')
		context_menu.set_item_metadata(idx, funcref(self, 'copy_resource'))		
		idx +=1
		
		context_menu.add_item('Duplicate')
		context_menu.set_item_metadata(idx, funcref(self, 'duplicate_resource'))
		idx +=1
		
		context_menu.add_item('Rename')
		context_menu.set_item_metadata(idx, funcref(self, 'rename_resource'))		
		idx +=1
		
		context_menu.add_item('Delete')	
		context_menu.set_item_metadata(idx, funcref(self, 'delete_resource'))	
		
	else :
		# Reset context menu size
		context_menu.rect_size = get_minimum_size()
	

func _on_name_entered(resname):
	var last = _selected_indices[_selected_indices.size()-1]
	var md = get_item_metadata(last)
	md.resname = resname	
	refresh()


func rename_resource():
	_rename_dialog.setup()
	
	
func copy_resource():
	print('copy res')
	
func duplicate_resource():
	print('dupe res')	
	
	
func delete_resource():
	print('del res')
		


func create_backtrack_item():
	add_item('...')
	#set_item_text(0, '...')

func create_resource_item(folder, resource):
	add_icon_item(resource.icon, true)
	var idx = get_item_count()-1 
	set_item_text(idx, resource.resname)
	set_item_metadata(idx, resource)
	#resource.configure_tree_item(item)
#	item.set_editable(0, true)
#	item.set_metadata(0, resource)	
#	item.set_tooltip(0, resource.path)
#	item.set_text(0, resource.resname)
#	item.set_selectable(0, true)


# @override
func get_drag_data(pos):
	return _dragndrop_behaviour.handle_get_drag_data(pos, _dnd_wrap_script)
	

# @override
func can_drop_data(pos, dnd_wrap):
	grab_focus()
	return dnd_wrap.handle_can_drop_data_on_file_system(self, pos)
	
# @override
func drop_data(pos, dnd_wrap):
	dnd_wrap.handle_drop_data_on_file_system(self, pos)
	
	
func drop_resources(pos, resources):	
	var idx = get_item_at_position(get_local_mouse_position())
	if _is_backtrack_item(idx) :
		move_resources(resources, _active_folder.folder)	
		
	var destination = get_item_metadata(idx)	
	if destination :
		if destination.is_folder() :
			move_resources(resources, destination)
			
	
# @impl
func create_selection_item_preview(idx):
	var md = get_item_metadata(idx)
	var hb = HBoxContainer.new()
	var tf = TextureRect.new()
	tf.set_texture(md.icon)
	hb.add_child(tf);
	var label = Label.new()
	label.set_text(md.resname)
	hb.add_child(label)	
	return hb
	
	

	

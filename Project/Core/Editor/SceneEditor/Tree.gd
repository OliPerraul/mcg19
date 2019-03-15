extends Tree

# @responsability manages and update the tree hierarchy
# TODO : handles the update tree mechanism (MoMaOpenSceneTreeHelper)


signal hierarchy_changed
signal query_attach_script


export(Script) onready var _dnd_wrapper_script
export(NodePath) onready var __dnd_behaviour
var _dnd_behaviour


func _ready():
	connect("item_edited", self, "_on_tree_item_edited")
	_dnd_behaviour = get_node(__dnd_behaviour)

# @desc		check if an element can sucessfully be changed position
# @param 	item
# @return 	success?
func _node_placement_can_change(node, relative_node):
		if node == relative_node :
				return false
		if node.is_a_parent_of(relative_node) :
				return false 
		return true		

# @desc		action performed when data is dropped on a tree item.
# @param 	item
# @return 	success?
func _data_dropped_between_item(data, relative_node, above):
	for element in data :
		var node = get_node(element)
		if not _node_placement_can_change(node, relative_node) :
			return false
		node.get_parent().remove_child(node)
		var parent = relative_node.get_parent()
		if above :
			Nodes.safe_add_node_above(relative_node, node) 
		else : 
			Nodes.safe_add_node_below(relative_node, node)
		return true


# @desc		action performed when data is dropped on a tree item.
# @param 	item
# @return 	success?
func _data_dropped_on_item(data, relative_node):
	# Reparent node	
	if is_instance_valid(relative_node) :
		for element in data :
			var node = get_node(element)
			if not _node_placement_can_change(node, relative_node) :
				return false
			node.get_parent().remove_child(node)
			relative_node.add_child(node)
	return true


func drop_open_scene_data(data, pos):
	var item = get_item_at_position(pos)
	if is_instance_valid(item) :
		var section = get_drop_section_at_position(pos)	
		var node = get_node(item.get_metadata(0))
		var flag
		if is_instance_valid(node) :
			if section == 1 :
				flag = _data_dropped_between_item(data, node, true)		
			elif section == 0 :
				flag = _data_dropped_on_item(data, node)
			elif section == -1 :
				flag = _data_dropped_between_item(data, node, false)
				
			if flag :
				emit_signal('hierarchy_changed')


func _drop_script_on_node(script_wrapper, item : TreeItem, node):
	
	#TextureButton = TextureButton.new()
	#button.set_normal_texture(script_wrapper.icon)
	#button.set_script(funcref(script_wrapper, 'open_resource'))
	
	item.add_button(0, script_wrapper.icon)
	emit_signal('query_attach_script', node, script_wrapper.resource)
	#item.add_button(
	#item.set_icon(2, script_wrapper.icon)
	pass



# @param data = script resource wrapper
# @ if dropped on node
func receive_script(data, pos):
	var item = get_item_at_position(pos)
	if is_instance_valid(item) :
		var section = get_drop_section_at_position(pos)	
		var node = get_node(item.get_metadata(0))
		var flag
		if is_instance_valid(node) :
			if section == 0 :
				_drop_script_on_node(data, item, node)
	

# @overrides
func drop_data(pos, data_wrapper):
	set_drop_mode_flags(0)
	data_wrapper.handle_drop_data_on_scene_editor(self, pos)


func _on_tree_item_edited():
	# Check if name exists amongst children
	var item = get_edited()
	var node = get_node(item.get_metadata(0))
	var new_name = item.get_text(0)	
	var parent = node.get_parent()
	# Do not allow naming to a node with same name
	for child in parent.get_children() :
		if child.get_name() == new_name:
			item.set_text(0, node.get_name())
			return			
	node.set_name(new_name)
	item.set_metadata(0, node.get_path())

# @override
func get_drag_data(pos):
	return _dnd_behaviour.handle_get_drag_data(pos, _dnd_wrapper_script)

# @override
func can_drop_data(pos, dnd_wrap):
	grab_focus()
	return dnd_wrap.handle_can_drop_data_on_scene_editor(self, pos)

# @imple
func create_selection_item_preview(item):
	var md = item.get_metadata(0)
	var hb = HBoxContainer.new()
	var tf = TextureRect.new()
	#tf.set_texture(md.icon)
	hb.add_child(tf);
	var label = Label.new()
	label.set_text(get_node(md).name)
	hb.add_child(label)	
	return hb


	






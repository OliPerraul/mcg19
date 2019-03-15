extends Node


func is_child(node, parent):
	return node.get_parent() == parent


func set_parent(node, parent):
	if is_instance_valid(node.get_parent()):
		node.get_parent().remove_child(node)
	parent.add_child(node)

func safe_add_node_above(node, child_node):
	node.get_parent().add_child(child_node)
	var pos = node.get_position_in_parent()-1
	if pos > -1 :
		node.call_deferred("move_child", child_node, pos)	
	
func safe_add_node_below(node, child_node):
	node.get_parent().add_child(child_node)
	var pos = node.get_position_in_parent()+1
	
	if pos < node.get_child_count() :
		node.call_deferred("move_child", child_node, pos)



func get_root():
	return Globals.game

func get_common_ancestor(node1, node2) :
	var cur = node1
	var root = get_root()
	while cur != root : 
		if cur.is_a_parent_of(node2) :
			return cur
		cur = cur.get_parent()
	return root


func get_space_global_transform(node, space):
	var cur = node
	var cur_tr = Transform2D.IDENTITY
	while cur != space: 
		if cur is CanvasItem :
			var tr = cur.get_transform()
			cur_tr = tr * cur_tr
		cur = cur.get_parent()
	return cur_tr


# TODO cache
func get_space_global_position(node, space):
	return get_space_global_transform(node, space).origin


func get_space_conversion_transform(node1, node2):
	var common_space = get_common_ancestor(node1, node2)
	var cm_sp_n = common_space.name
	var tr1 : Transform2D = get_space_global_transform(node1, common_space)
	var tr2 : Transform2D = get_space_global_transform(node2, common_space)	
	return tr1 * tr2.inverse()
	


func set_parent_preserve_common_space_position(node, parent):
	var conv_tr : Transform2D = get_space_conversion_transform(node, parent)
	Nodes.set_parent(node, parent)
	node.set_position(conv_tr.get_origin()) # Sets the converted pos
	node.set_rotation(conv_tr.get_rotation())
	node.set_scale(conv_tr.get_scale())



func control_make_full_rect(control):
	control.set_anchors_and_margins_preset(Control.PRESET_WIDE)
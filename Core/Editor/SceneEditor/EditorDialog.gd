extends WindowDialog

var _open_node


export(NodePath) var __tree
var _tree


export(NodePath) var __moma_open_scene_editor_helper
var _moma_open_scene_editor_helper


func _ready():
	_tree = get_node(__tree)
	_tree.connect("hierarchy_changed", self, "_on_tree_hierarchy_changed") # TODO : update tree inside Tree
	_tree.connect('query_attach_script', self, 'attach_script')
	

func setup(node):
	_open_node = node
	_moma_open_scene_editor_helper = get_node(__moma_open_scene_editor_helper)
	_moma_open_scene_editor_helper.setup(_tree, _open_node)
	
	# Sets the node to be child of the foreground while keeping the same global pos
	Nodes.set_parent_preserve_common_space_position(self, Globals.world.foreground)
	call_deferred("update_tree")
	
	
	
func _on_tree_hierarchy_changed():
	call_deferred("update_tree")


func attach_script(node, script):
	if node.get_script() == null:
		node.set_script(script)
		

func open():
	rect_size = get_minimum_size()
	if not visible :
		popup()


func _process(delta):
	#Nodes.get_absolute_global_position(self)
	pass


func update_tree():
	_moma_open_scene_editor_helper.update_tree()
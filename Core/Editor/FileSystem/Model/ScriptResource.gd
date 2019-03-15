extends 'Resource.gd'


func _init():
	drop_mode_flags = Tree.DROP_MODE_ON_ITEM


func handle_can_drop_data_on_scene_editor(target, pos):
	return true

# diff res types do diff things
func handle_drop_data_on_scene_editor(target, pos):
	target.receive_script(self, pos)
	
	
func handle_activated_by_file_system(file_system):
	file_system.open_script_resource(self)
	pass
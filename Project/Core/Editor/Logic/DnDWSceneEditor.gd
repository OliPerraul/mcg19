extends 'DnDWrapper.gd'



	
func handle_can_drop_data_on_file_system(target, pos):
	return true

# @abstr
# @desc		Perform correct action for a given target
func handle_drop_data_on_file_system(target, pos):
	pass


	
func handle_can_drop_data_on_scene_editor(target, pos):
	target.set_drop_mode_flags(3)
	return true


func handle_drop_data_on_scene_editor(target, pos):
	target.drop_open_scene_data(data, pos)


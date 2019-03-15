extends 'DnDWrapper.gd'


func handle_can_drop_data_on_file_system(target, pos):
	return true


# @imple	Perform correct action for a given target
func handle_drop_data_on_file_system(target, pos):
	return target.drop_resources(pos, data)
	
		
func handle_can_drop_data_on_scene_editor(target, pos):
	#target.set_drop_mode_flags(3)
	# Overwrite drop mode flags if resource is a script or other (aka drop only on target)
	for res in data :
		if not res.handle_can_drop_data_on_scene_editor(target, pos):
			#target.set_drop_mode_flags(0)
			return false 
		
		if res.drop_mode_flags != 3 :
			#target.set_drop_mode_flags(res.drop_mode_flags)
			break
		
	return true
	
# @imple	Perform correct action for a given target
func handle_drop_data_on_scene_editor(target, pos):
	for res in data :
		res.handle_drop_data_on_scene_editor(target, pos)	
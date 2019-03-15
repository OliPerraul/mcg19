extends Object


var data

# @abstr
# @desc		Perform correct action for a given target
func handle_can_drop_data_on_tree_editor(target, pos):
	return true
	
# @abstr
# @desc		Perform correct action for a given target
func handle_drop_data_on_tree_editor(target, pos):
	pass


func handle_can_drop_data_on_file_system(target, pos):
	return true


func handle_drop_data_on_file_system(target, pos):
	pass


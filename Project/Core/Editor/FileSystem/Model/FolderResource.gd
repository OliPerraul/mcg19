extends 'Resource.gd'

var content : Array


func _init():
	content = Array()


func handle_can_drop_data_on_scene_editor(target, pos):
	return false

# diff res types do diff things
func handle_drop_data_on_scene_editor(target, pos):
	print('folder dropped (Not implemented)')



func is_folder():
	return true

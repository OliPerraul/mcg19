
extends Node

var icon = ''
var path = ''
var resname = ''

# Actual resource
var folder
var resource = ''
var drop_mode_flags = 3 # all

# @abstract
#func configure_tree_item(item : TreeItem):
#	item.set_icon(0, icon)
	
	
func handle_can_drop_data_on_scene_editor(target, pos):
	return true

# diff res types do diff things
func handle_drop_data_on_scene_editor(target, pos):
	pass


func handle_activated_by_file_system(file_system):
	pass


func free():
	folder.content.erase(self)
	
func is_folder():
	return false
	
	
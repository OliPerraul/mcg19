extends 'Resource.gd'



func handle_drop_data(target, pos):
	print('sprite dropped (Not implemented)')


func handle_activated_by_file_system(file_system):
	file_system.open_sprite_resource(self)
	pass
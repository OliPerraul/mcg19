tool
extends AtlasTexture

export (bool) var generate_frames = false setget _do_generate_frames
export (bool) var flag_generate_reverse = false


export(int) var _image_number = 8 setget set_image_number
export(int) var _image_index = 0 setget set_image_index


export(Vector2) var _image_dimension = Vector2(64,64) setget set_image_dimension
export(int) var _num_columns = 8 setget set_num_columns
export(int) var _num_rows = 1 setget set_num_rows

	
func set_image_index(value):
	_image_index = value
	_update_selection()

func set_image_number(value):
	_image_number = value
	_update_selection()
	
func set_image_dimension(value):
	_image_dimension = value
	_update_selection()
		
func set_num_columns(value):
	_num_columns = value
	_update_selection()
	
func set_num_rows(value):
	_num_rows = value
	_update_selection()


func _update_selection():
	print("Update Atlas..")
	var w = atlas.get_width()
	var h = atlas.get_height()
		
	var xx = _image_index % _num_columns
	var yy = _image_index/_num_columns #grid pos
	
	var x = xx*_image_dimension.x
	var y = yy*_image_dimension.y
	
	
	region.position = Vector2(x,y)
	region.size = _image_dimension
		 
	
func _do_generate_frames(value):
	if value:
		
		print("Generate Frames..")
		
		var res = load(resource_path)
		var dir = resource_path.get_base_dir().get_base_dir()
		var file = resource_path.get_basename().get_file()
		
		var path_no_name = dir+'/'+file+'_'
		
				
		for i in range(_image_number):
			
			##Reverse if needed
			###
			var k = i
			if flag_generate_reverse:
				k = (_image_number-1)-i
			###
			
			
			var path = path_no_name
			
			if i < 10:
				path += '0' + String(k)+'.tres'
			else:
				path += String(k)+'.tres'
				
			var copy = res.duplicate()
			copy._image_index = k
			copy.set_script(null)
			
			
			ResourceSaver.save(path, copy)
			
		
					
		
		
	
		
	
	
	

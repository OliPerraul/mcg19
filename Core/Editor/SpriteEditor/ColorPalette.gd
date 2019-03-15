extends ItemList

signal color_changed


#NOTE: max 8x8
export(StreamTexture) var _palette_source_texture
export(StreamTexture) var _icon_source_texture
export(StreamTexture) var _icon_transparent_source_texture

var _palette_image
var _icon_image

var _colors =  Array()
var _color_selected 
var _prev_selected = 0


func _ready():
	
	connect("item_selected", self, "_update_selected_color")
	
	_palette_image = _palette_source_texture.get_data()
	_icon_image = _icon_source_texture.get_data()
	
	_generate_palette(true)
	_update_palette()
	pass


func _update_selected_color(index):
	
	#clear previous selection
	set_item_custom_bg_color(_prev_selected, Colors.TRANS) 
	_prev_selected = index
	
	# update selection
	set_item_custom_bg_color(index, Colors.WHITE)
	
	# emit signal
	var col = Colors.TRANS
	if index<len(_colors):
		col = _colors[index]
	
	emit_signal("color_changed", col)
	


func _generate_palette(value):
	var width = _palette_image.get_width()
	var height = _palette_image.get_height()

	for i in range(height):
		for j in range(width):
			
			_palette_image.lock()
			var col = _palette_image.get_pixel(j, i)
			_palette_image.unlock()
		
			if _colors.find(col) == -1:
				_colors.push_back(col)

	
func _update_palette():
	clear()
		
	for col in _colors:
		_icon_image.fill(col)
		
		var icon_texture = ImageTexture.new()
		icon_texture.create_from_image(_icon_image, 0)
		add_icon_item(icon_texture)
	
	# Add transparent icon
	add_icon_item(_icon_transparent_source_texture)
	

	
extends TextureRect

export(NodePath) onready var _background = get_node(_background)
export(NodePath) onready var _brush = get_node(_brush)
export(NodePath) onready var _cursor = get_node(_cursor)


export(Vector2) var _dimension = Vector2(48,48) setget set_dimension

export(Vector2) var _offset_brush_cursor = Vector2(-1, -1)

export(float) var _size_brush_cursor = 1.5
export(float) var _alpha_brush_cursor = .2

export(Color)  var _brush_color

export(StreamTexture)  var _sprite_source_texture
export(StreamTexture)  var _brush_cursor_source_texture
export(StreamTexture)  var _background_source_texture

var _sprite_texture = null
var _sprite_image = null

var _brush_texture = null
var _brush_image = null


var _pos = Vector2(0,0)
var _brush_pos = Vector2(0,0)
var _brush_positions = Array()

export(int)  var _scale = 2
export(int) var _scale_max = 8
export(int) var _scale_min = 1

export(int) var _brush_size_max = 8
export(int) var _brush_size_min = 1
var _brush_size = 1


var _flag_focused = false

### PRIVATE

#####

func _ready():
	
	set_process_input(true)
	
	#image
	_sprite_image = Image.new()
	_sprite_image.create(_dimension.x,_dimension.y, false,Image.FORMAT_RGBA8)
	_sprite_texture = ImageTexture.new()
	texture = _sprite_texture
	
	
	#cursor
	_cursor.texture = _brush_cursor_source_texture
			
	#background
	_background.texture = _background_source_texture
		
	
	#brush
	_brush_image = Image.new()
	_brush_image.create(_dimension.x,_dimension.y, false,Image.FORMAT_RGBA8)
	_brush_texture = ImageTexture.new()
	_cursor.texture = _brush_texture
	

func _process(delta):
	
	if _flag_focused:
		
		_pos = get_transform().get_origin()
		
		if _check_pos_in_canvas(_get_mouse_rel_pos()):
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
						
			if Input.is_action_pressed("ui_mb_left"): #continuous draw
				_apply_brush()		
			
			_process_brush()
			
			_process_textures()
			_process_texture_rects()
						
			
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) #reset visible
		
		# redraw canvas item
		update()


func _input(event):
	
	if _flag_focused:
	
		if event is InputEventMouseButton:
			
			if _check_pos_in_canvas(_get_mouse_rel_pos()):
			
				if (event.button_index == BUTTON_WHEEL_UP):
					if Input.is_action_pressed("ui_ctrl"):
						_apply_zoom(1)
					else:
						_resize_brush(1)
				
				if (event.button_index == BUTTON_WHEEL_DOWN):
					if Input.is_action_pressed("ui_ctrl"):
						_apply_zoom(-1)
					else:
						_resize_brush(-1)
							
				if event.button_index == BUTTON_RIGHT:
					_apply_sampler()


#####

func _get_mouse_rel_pos():
	var pos = get_local_mouse_position() 
	pos/=_scale
	pos = Vector2(round(pos.x), round(pos.y))
	return pos
	pass
	
func _check_pos_in_canvas(pos):	
	if pos.x > _dimension.x-1:
		return false
		
	if pos.x < 0 :
		return false
		
	if pos.y > _dimension.y-1:
		return false
		
	if pos.y < 0 :
		return false
			
	return true	
	pass
	
#####


func _process_brush():
	_brush_positions.clear()
	_brush_pos = _get_mouse_rel_pos()
	
	#get brush pixels
	for i in range(_brush_size):
		for j in range(_brush_size):
			var pos = Vector2(_brush_pos.x+i-_brush_size/2, _brush_pos.y+j-_brush_size/2)
			if _check_pos_in_canvas(pos):
				_brush_positions.push_back(pos)
	
	_process_brush_image()

func _process_brush_image():
	_brush_image.fill(Colors.TRANS)
	_brush_image.lock()
	for pos in _brush_positions:
		_brush_image.set_pixel(pos.x, pos.y, _brush_color)
	_brush_image.unlock()
	
func _process_textures():
	_sprite_texture.create_from_image(_sprite_image, 0) #create with no flag
	_brush_texture.create_from_image(_brush_image, 0)
	
func _process_texture_rects():
	
	var size = _dimension
	size = _dimension*_scale
	set_size(size)

	

# Quick tools (TODO replace with selecrable tools)

func _resize_brush(incr):
	_brush_size = clamp(_brush_size+incr, _brush_size_min, _brush_size_max)
			
func _apply_brush():
	_sprite_image.lock()
	for pos in _brush_positions:
		_sprite_image.set_pixel(pos.x, pos.y, _brush_color)
	_sprite_image.unlock()
		
func _apply_sampler():
	_sprite_image.lock()
	var color = _sprite_image.get_pixel(_brush_pos.x, _brush_pos.y)
	_sprite_image.unlock()
	set_brush_color(color)
	
func _apply_zoom(amount):
	_scale = clamp(_scale+amount, _scale_min, _scale_max)
	
#####
	

### PUBLIC

func get_sprite():
	return _sprite_image
	pass


func on_general_focus_changed(change):
	_flag_focused = change
	pass

func set_dimension(dim):
	rect_size = dim
	rect_min_size = dim
	_dimension = dim
	pass

func set_brush_color(color):
	_brush_color = color
	pass


		
	
	
	

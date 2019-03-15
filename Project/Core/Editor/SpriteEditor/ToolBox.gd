extends ItemList

signal tool_changed


#NOTE: max 8x8
#export(StreamTexture) var _icon_save
#export(StreamTexture) var _icon_delete
#export(StreamTexture) var _icon_new_sprite
#export(StreamTexture) var _icon_new_img


export(StreamTexture) var _icon_pencil
export(StreamTexture) var _icon_fill
export(StreamTexture) var _icon_clear
export(StreamTexture) var _icon_eyedropper
export(StreamTexture) var _icon_move
export(StreamTexture) var _icon_zoom

export(StreamTexture) var _icon_draw_line
export(StreamTexture) var _icon_draw_curve
export(StreamTexture) var _icon_draw_rect
export(StreamTexture) var _icon_draw_ellipse


export(StreamTexture) var _icon_select_rect
#export(StreamTexture) var _icon_select_circle
#export(StreamTexture) var _icon_select_free


var _index_prev_selected = 0

#contains reference to the tool object
var _tool_active = null


func _ready():
	set_focus_mode(FOCUS_CLICK)
	connect("item_selected", self, "_update_tool_selected")
	add_icon_item(_icon_pencil)
	add_icon_item(_icon_fill)
	add_icon_item(_icon_clear)
	add_icon_item(_icon_eyedropper)
	add_icon_item(_icon_move)
	add_icon_item(_icon_zoom)
	add_icon_item(_icon_draw_line)
	add_icon_item(_icon_draw_curve)
	add_icon_item(_icon_draw_rect)
	add_icon_item(_icon_draw_ellipse)
	add_icon_item(_icon_select_rect)
	

func _update_tool_selected(index):
	
	#clear previous selection
	set_item_custom_bg_color(_index_prev_selected, Colors.TRANS) 
	_index_prev_selected = index
	
	# update selection
	set_item_custom_bg_color(index, Colors.WHITE)
	
	emit_signal("tool_changed")
	
func get_tool():
	pass
	
	



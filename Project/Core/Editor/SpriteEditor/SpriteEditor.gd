extends Control

export(NodePath) onready var __canvas
var _canvas

export(NodePath) onready var __palette
var _palette

export(NodePath) onready var __tool_box
var _tool_box

export(NodePath) onready var __save_button
var _save_button

export(NodePath) onready var __new_button
var _new_button

export(NodePath) onready var __open_button
var _open_button


var _output

func _ready():
	_canvas = get_node(__canvas)
	_palette = get_node(__palette)
	_tool_box = get_node(__tool_box)
	_save_button = get_node(__save_button)
	_new_button = get_node(__new_button)
	_open_button = get_node(__open_button)
	
	connect("general_focus_changed", _canvas, "on_general_focus_changed")
	_palette.connect("color_changed", _canvas, "set_brush_color")	
	# _tool_box.connect("tool_changed", _canvas, "set_active_tool")	
	_save_button.connect("button_down", self, "_save")


func set_output(output):
	_output = output


func _save(): #name, ar_frames
	#var img_sprite = _canvas.get_sprite()
	#var n = _scr_user_sprite.create("", Array())
		
	
	pass
	
	
func _save_as():
	pass
	
func _open():
	pass


func _new():
	pass


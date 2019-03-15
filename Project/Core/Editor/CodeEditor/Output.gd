extends Control


export(NodePath) onready var __rich_text_label
var _rich_text_label : RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	_rich_text_label = get_node(__rich_text_label)
	_rich_text_label.set_scroll_follow(true)
	#_scroll_container = get_node(__scroll_container)

func clear():
	_rich_text_label.text = ''

func output(msg):
	_rich_text_label.text += '\n'+str(msg)	
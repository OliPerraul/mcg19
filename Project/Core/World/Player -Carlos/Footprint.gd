extends Node2D

export(float) onready var priority = 100
onready var type = Globals.DETECTABLE.FOOTPRINT

var footprint_stack 
var sprite: Sprite


func _ready():
	add_to_group("detectable")
	#sprite = Sprite.new()
	#sprite.set_texture(load("House1.png"))


func _set_reference(ref):
	footprint_stack = ref

func _set_position(pos):
	print(pos)
	global_position = pos
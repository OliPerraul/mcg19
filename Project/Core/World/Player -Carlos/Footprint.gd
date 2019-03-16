extends Node2D

export(float) onready var priority = 100
onready var type = Globals.DETECTABLE.FOOTPRINT

var footprint_stack 
var sprite: Sprite


var time = 0
export(float) var time_limit = 2


func _ready():
	add_to_group("detectable")
	#sprite = Sprite.new()
	#sprite.set_texture(load("House1.png"))


func _process(delta):
	time += delta
	if time >= time_limit:
		time = 0
		var idx = footprint_stack.find(self)
		if idx != -1:
			footprint_stack.remove(idx)
			
		self.queue_free()	
			

func _set_reference(ref):
	footprint_stack = ref

func _set_position(pos):
	print(pos)
	global_position = pos

func orientation(d):
	match(d):
		"north":
			rotation = 4*2*PI/4 
		"south":
			rotation = 2*2*PI/4
		"east":
			rotation = 1*2*PI/4
		"west":
			rotation = 3*2*PI/4
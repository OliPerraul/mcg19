extends Node2D




#CHILD NODES TO load
var footprint
var sprite
var area_2D


#EXPORTED
export(String) var facing
# north
# east
# south
# west
export(String) var movement_state
# idle
# walking
export(String) var character_state
#	normal
#	danger
#	involuntary
export(float) var speed
export(float) var footprint_decay = 1

#PRIVATES
var footprint_array
var footprint_timer




#TODO : CatchEventManager Signals



func _ready():
	call_deferred("_post_ready")

func _post_ready():
	footprint = preload("Footprint.tscn") # Will load when parsing the script.
	sprite = get_node("sprite")
	area_2D = get_node("area_2D")

	#setup footprints and timer for decay
	footprint_array = []
	footprint_timer = get_node("footprint_timer")
	footprint_timer.set_wait_time(footprint_decay)
	#footprint_timer.set_process_mode(1)
	footprint_timer.set_one_shot(false)
	footprint_timer.connect("timeout", self, "_footprint_timer_timeout")
	




#Update loop
func _process(dt):
	input_handler()

func step():
	var fp = footprint.instance()
	footprint_array.push_front(fp)
	add_child(footprint_array[0])

	if(footprint_timer.get_time_left()==0):
		footprint_timer.start()

func _footprint_timer_timeout():
	var fp = footprint_array.pop_back()
	fp.free()

	if(!footprint_array.empty()):
		footprint_timer.start()
	else:
		footprint_timer.stop()


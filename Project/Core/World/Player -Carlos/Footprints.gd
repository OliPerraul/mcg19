extends Node2D

var footprint
var footprint_array: Array
var footprint_timer: Timer

export(float) var footprint_decay = 1




func _ready():
	#setup footprints and timer for decay
	footprint_array = []
	footprint_timer = Timer.new()
	footprint_timer.set_wait_time(footprint_decay)
	#footprint_timer.set_process_mode(1)
	footprint_timer.set_one_shot(false)
	footprint_timer.connect("timeout", self, "_footprint_timer_timeout")
	add_child(footprint_timer)



func add():
	var fp = footprint.instance()
	footprint_array.push_front(fp)
	add_child(footprint_array[0])
	#print("Step!")

	if(footprint_timer.get_time_left()==0):
		footprint_timer.start()

func _footprint_timer_timeout():
	var fp = footprint_array.pop_back()
	fp.free()
	#print("footprint cleared	")

	if(!footprint_array.empty()):
		footprint_timer.start()
	else:
		footprint_timer.stop()


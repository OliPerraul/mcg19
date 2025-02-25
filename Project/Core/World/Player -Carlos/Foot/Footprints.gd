extends Node2D


var footprint_array: Array
var footprint_timer: Timer
var sfx_player: AudioStreamPlayer2D

export(Array, AudioStream) onready var soundArray

export(float) var footprint_decay = 4


export(Resource) onready var footprint


export(int) onready var max_fp = 20 


func _ready():

	footprint_array = []
	#footprint_timer = Timer.new()
	footprint_timer = get_node("Timer")
	footprint_timer.set_wait_time(footprint_decay)
	#footprint_timer.set_process_mode(1)
	footprint_timer.set_one_shot(false)
	footprint_timer.connect("timeout", self, "_footprint_timer_timeout")
	add_child(footprint_timer)
	sfx_player = get_node("AudioStreamPlayer2D")
	sfx_player.volume_db = -28


func add(direction):
	var fp = footprint.instance()
	_play_footstep()
	
	fp._set_reference(footprint_array)
	fp._set_position(get_parent().global_position)
	fp.orientation(direction)
	footprint_array.push_front(fp)
	
	if(len(footprint_array)>= max_fp):
		_footprint_timer_timeout() #TODO: rename
	
	get_tree().get_root().add_child(footprint_array[0])
	#print("Step!")

	if(footprint_timer.get_time_left()==0):
		footprint_timer.start()

func _footprint_timer_timeout():
	var fp = footprint_array.pop_back()
	if is_instance_valid(fp):
		fp.free()
	if(!footprint_array.empty()):
		footprint_timer.start()
	else:
		footprint_timer.stop()

func _play_footstep():
	sfx_player.set_stream(soundArray[randi()%5])
	sfx_player.play()


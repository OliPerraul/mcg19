extends KinematicBody2D




#CHILD NODES TO load
var footprint
var sprite
var area_2D


#EXPORTED
export(String) var facing = "south"
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
export(float) var speed = 4
export(float) var animation_speed = 0.1
export(float) var footprint_decay = 1

#PRIVATES
var footprint_array: Array
var footprint_timer: Timer

var movement : Vector2 = Vector2(0,0)





#TODO : CatchEventManager Signals



func _ready():
	call_deferred("_post_ready")


func _post_ready():
	# load nodes
	footprint = preload("Footprint.tscn") 
	sprite = get_node("sprite")
	area_2D = get_node("area_2D")

	#setup footprints and timer for decay
	footprint_array = []
	footprint_timer = Timer.new()
	footprint_timer.set_wait_time(footprint_decay)
	#footprint_timer.set_process_mode(1)
	footprint_timer.set_one_shot(false)
	footprint_timer.connect("timeout", self, "_footprint_timer_timeout")
	add_child(footprint_timer)





#Update loop
func _physics_process(dt):
	input_handler()
	move_and_slide(movement*250)



func step():
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


func input_handler():
	if Input.is_action_just_released("player_movement"):
		movement_state = "idle"
		movement = Vector2(0,0)

	if Input.is_action_pressed("player_up"):
		movement_state = "walking"
		facing = "north"
		movement.y -= speed

	if Input.is_action_pressed("player_down"):
		movement_state = "walking"
		facing = "south"
		movement.y += speed

	if Input.is_action_pressed("player_left"):
		movement_state = "walking"
		facing = "west"
		movement.x -= speed

	if Input.is_action_pressed("player_right"):
		movement_state = "walking"
		facing = "east"
		movement.x += speed

	if Input.is_action_just_released("ui_accept"):
		step()
		
	movement = movement.normalized()

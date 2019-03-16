extends Sprite

var speed : float
var h_frame : int = 0
var timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	speed = get_parent().animation_speed

	timer = Timer.new()
	timer.set_wait_time(speed)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "_update")
	add_child(timer)
	timer.start()
	print("run")



func _update():
	
	match(get_parent().movement_state):
		"idle":
			h_frame = 0
		"walking":
			lp()
	#print("v:"+String(dir()*8)+" h:"+String(h_frame))
	set_frame( dir()*8 + h_frame)
	


func dir():
	match(get_parent().facing):
		"north":
			return 1
		"south":
			return 0
		"east":
			return 3
		"west":
			return 2
		_:
			return 0

func lp():
	if(h_frame<get_hframes()-1):
		h_frame = h_frame+1
	else:
		h_frame = 0
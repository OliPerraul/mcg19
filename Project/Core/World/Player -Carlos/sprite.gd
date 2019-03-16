extends Sprite

var speed : float
var h_frame : int
var timer: Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	speed = get_parent().animation_speed

	timer = Timer.new()
	timer.set_wait_time(speed)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "_update")



func _update():
	match(get_parent().movement_state):
		"idle":
			h_frame = 0
		"walking":
			h_frame = lp()

	set_frame( dir()*get_vframes() + h_frame )


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

func lp():
	if(get_hframes()!=h_frame+1):
		h_frame = h_frame+1
	else:
		h_frame = 0
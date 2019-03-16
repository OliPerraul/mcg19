extends OLI_STATE_ALERT

var _dest


var time_idle = 0
export(float) onready var time_limit_idle = 2


func setup(context, args):
	time_idle = 0
	

func update(context, delta):	
	.update(context,delta)
	time_idle += delta
	if time_idle >= time_limit_idle:
		context.fsm.set_state_named('Home')
		time_idle = 0

	

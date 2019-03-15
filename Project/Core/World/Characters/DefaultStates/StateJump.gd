
extends 'StateBase.gd'

export(float) onready var _JSPD


func setup(context, args):
	.setup(context, args)
	context.velocity.y -=_JSPD
	#context.position += context.velocity	
	context.emit_signal('start_moving')
	context.fsm.set_state_named("Airborne", [])



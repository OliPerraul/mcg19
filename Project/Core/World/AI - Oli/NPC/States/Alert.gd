class_name OLI_STATE_ALERT
#extends OLI_STATE
extends "res://Core/World/AI - Oli/FSM/State.gd"

# GO TO EVENT LOCATION
# (CAR ALARM etc.)

var time_detection = 0
export(float) onready var time_detection_limit = 1


func setup(context, args):
	time_detection = 0
	pass
	
func clean():
	pass


func update(context, delta):	
	if context.vision.target != null:
		time_detection += delta
		if time_detection > time_detection_limit :			
			match(context.vision.target.type):
				Globals.DETECTABLE.PLAYER, Globals.DETECTABLE.ALARM:
					context.fsm.set_state_named('Chase', [context.vision.target])
				Globals.DETECTABLE.FOOTPRINT:
					context.fsm.set_state_named('Trace')
	else:
		time_detection = 0
	
	
	
	
func physics_update(context, delta):
	pass
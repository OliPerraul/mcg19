class_name OLI_STATE_ALERT
extends OLI_STATE

# GO TO EVENT LOCATION
# (CAR ALARM etc.)


func setup(context, args):
	pass
	
func clean():
	pass


func update(context):
	if context.vision.target != null:
		match(context.vision.target.type):
			Globals.DETECTABLE.PLAYER, Globals.DETECTABLE.ALARM:
				context.fsm.set_state_named('Chase', [context.vision.target])
			Globals.DETECTABLE.FOOTPRINT:
				context.fsm.set_state_named('Trace')
	
	
	
	
func physics_update(context, delta):
	pass
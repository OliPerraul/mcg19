extends OLI_STATE


var _target
var _dest

var time_outside_detection = 0
export(float) onready var time_outside_detection_limit = .5

export(float) var spd = 2 
export(float) onready var alert_raise_incr = .1


func setup(context, args):
	.setup(context, args)
	time_outside_detection = 0
	_target = args[0]
	#context.astar_agent.global_transform.origin = context.global_transform.origin
	_dest = _target.global_transform.origin
	
	#context.astar_agent.move_to(_dest)
	
	
func update(context, delta):
	.update(context, delta)
	
	if context.vision.target != _target:
		time_outside_detection += delta
		if time_outside_detection > time_outside_detection_limit :
			context.emoji.play('Warning')
			context.fsm.set_state_named('Idle')
			return	
				
	else:
		if context.vision.target != null and context.vision.target.priority > 0:
			context.emoji.play('Danger')
			time_outside_detection = 0
			context.direction = (context.vision.target.global_position - context.global_position).normalized()
			Globals.game.update_alert(alert_raise_incr)
		else:
			context.emoji.play('Warning')
			context.fsm.set_state_named('Idle')
			return	

		
	
	
	




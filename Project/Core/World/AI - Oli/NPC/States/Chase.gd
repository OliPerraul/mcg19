extends OLI_STATE_ALERT


var _target
var _dest

var time_outside_detection = 0
export(float) onready var time_outside_detection_limit = 1


func setup(context, args):
	.setup(context, args)
	time_outside_detection = 0
	_target = args[0]
	context.astar_agent.global_transform.origin = context.global_transform.origin
	_dest = _target.global_transform.origin
	context.astar_agent.move_to(_dest)
	

func update(context, delta):
	.update(context, delta)
	var last_position = context.global_transform.origin
	context.global_transform.origin = lerp(context.global_transform.origin, context.astar_agent.global_transform.origin, context.lerp_speed)
	context.direction = context.global_transform.origin - last_position
	
	if context.vision.target != _target:
		time_outside_detection += delta
		if time_outside_detection > time_outside_detection_limit :			
			context.fsm.set_state_named('Idle')
			return
	else:
		time_outside_detection = 0
		
	if not Vectors.close_enough(_dest, _target.global_transform.origin):
		#context.astar_agent.global_transform.origin = context.global_transform.origin
		_dest = _target.global_transform.origin
		context.astar_agent.move_to(_dest)
		
	






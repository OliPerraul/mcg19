extends OLI_STATE


var _target
var _dest

#TODO set direction towards

func setup(context, args):
	.setup(context, args)	
	_target = args[0]
	context.astar_agent.global_transform.origin = context.global_transform.origin
	_dest = _target.global_transform.origin
	context.astar_agent.move_to(_dest)
	

func update(context):
	.update(context)
	var last_position = context.global_transform.origin
	context.global_transform.origin = lerp(context.global_transform.origin, context.astar_agent.global_transform.origin, context.lerp_speed)
	context.direction = context.global_transform.origin - last_position
	
	if not Vectors.close_enough(_dest, _target.global_transform.origin):
		context.astar_agent.global_transform.origin = context.global_transform.origin
		_dest = _target.global_transform.origin
		context.astar_agent.move_to(_dest)






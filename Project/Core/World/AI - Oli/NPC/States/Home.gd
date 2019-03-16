extends OLI_STATE_ALERT

var _dest

func setup(context, args):
	_dest = context.path_agent.get_closest_point(context)
	context.astar_agent.global_transform.origin = context.global_transform.origin
	context.astar_agent.move_to(_dest)
	
	
func clean():
	pass


func update(context, delta):	
	.update(context,delta)
		
	var last_position = context.global_transform.origin
	context.global_transform.origin = lerp(context.global_transform.origin, context.astar_agent.global_transform.origin, context.lerp_speed)
	context.direction = context.global_transform.origin - last_position
	
	if Vectors.close_enough(context.global_position, _dest, 20) :
		context.fsm.set_state_named('Patrol')
		return
	
	
		
func physics_update(context, delta):
	pass
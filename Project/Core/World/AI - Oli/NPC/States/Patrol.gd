extends OLI_STATE_ALERT

func setup(context, args):
	context.path_agent.reset()
	pass
	
func clean():
	pass

func update(context):
	.update(context)
	var last_position = context.global_transform.origin
	context.global_transform.origin = lerp(context.global_transform.origin, context.path_agent.global_transform.origin, context.lerp_speed)
	context.direction = context.global_transform.origin - last_position
	
	
	
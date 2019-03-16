extends OLI_STATE


func setup(context, args):
	context.path_agent.reset()
	pass
	
func clean():
	pass

func update(context):
	context.transform.origin = lerp(context.transform.origin, context.path_agent.transform.origin, context.lerp_speed)
	
	
	
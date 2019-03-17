extends OLI_STATE_ALERT

var _dest
var started = false
var arrived = false

func setup(context, args):
	_dest = context.path_agent.get_closest_point(context)
	context.astar_agent.global_transform.origin = context.global_transform.origin
	context.astar_agent.move_to(_dest)
	started = false
	arrived = false

func clean():
	pass


func update(context, delta):	
	.update(context,delta)
	
#	var last_position = context.global_transform.origin
#	context.global_transform.origin = lerp(context.global_transform.origin, context.astar_agent.global_transform.origin, context.lerp_speed)
#	context.direction = context.global_transform.origin - last_position
	
	if !started:
		$Tween.interpolate_property(context, "global_position", context.global_position, context.astar_agent.global_transform.origin, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		started = true
	elif arrived:
		context.fsm.set_state_named('Patrol')

func _on_Tween_tween_completed(object, key):
	arrived = true

func physics_update(context, delta):
	pass
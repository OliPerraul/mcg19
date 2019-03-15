
extends 'StateBase.gd'


export(float) var _WALK_THRESHOLD = .01
export(float) var _RUN_THRESHOLD = .5


func setup(context, args):
	.setup(context, args)
	context.velocity.y = 0


func update(context):
	#	
	if abs(context.controller.horizontal) > _WALK_THRESHOLD:	
		context.fsm.set_state_named("GroundMovement", [])
	else:
		context.velocity.x = 0
		context.fsm.set_state_named("Idle", [])
			
	# Jump
	if context.controller.jump_pressed:
		context.fsm.set_state_named("Jump",[])
	
	if not context.world_collider.check_floor_collision():
		context.fsm.set_state_named("Airborne", [])
	


		

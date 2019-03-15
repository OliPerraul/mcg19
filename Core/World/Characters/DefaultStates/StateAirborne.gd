
extends 'StateBase.gd'

export(float) onready var _HSPEED
export(float) onready var _GRAV 

export(float) onready var _DECELERATION
export(float) onready var _ACCELERATION

var _velocity = Vector2(0,0)


func clean():
	pass

func setup(context, args):
	.setup(context, args)

func update(context):
	if context.world_collider.check_floor_collision():
		context.fsm.set_state_named("Grounded", [])
	else :
		context.emit_signal("moving")
		context.velocity.y += _GRAV	
		
		context.velocity.x = context.controller.horizontal*_HSPEED

#		if context.world_collider.check_wall_collision() == 1 :
#			context.velocity.x = clamp(context.velocity.x, 0, INF)
#		elif context.world_collider.check_wall_collision() == 2 :
#			context.velocity.x = clamp(context.velocity.x, -INF, 0)

		
		
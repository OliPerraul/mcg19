
extends 'StateGrounded.gd'

export(float) onready var _SPEED = 2
export(float) onready var _DECELERATION = 1.0
export(float) onready var _ACCELERATION = 1.0


func setup(context, args):
	context.emit_signal('start_moving')

func update(context):
	.update(context)
			
	context.velocity.x = context.controller.horizontal*_SPEED	
	
#	if context.world_collider.check_wall_collision() == 1 :
#		context.velocity.x = clamp(context.velocity.x, 0, INF)
#	elif context.world_collider.check_wall_collision() == 2 :
#		context.velocity.x = clamp(context.velocity.x, -INF, 0)

	if abs(context.controller.horizontal) > _RUN_THRESHOLD :
		context.emit_signal("moving")
		context.animated_sprite.play("Run")
	elif abs(context.controller.horizontal) > _WALK_THRESHOLD:
		context.emit_signal("moving")
		context.animated_sprite.play("Walk")
	
	




		

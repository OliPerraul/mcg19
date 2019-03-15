extends 'res://Core/Logic/FSM/State.gd'


func setup(context, args):
	# TODO put somewhere else
	if not context.world_collider.is_connected('collided_with_wall', self, '_on_collided_with_wall') :
		context.world_collider.connect('collided_with_wall', self, '_on_collided_with_wall', [context])

# @abstract
func _on_collided_with_wall(context) :
	#print('WALL COLLISION')
	#context.velocity.x = 0
	pass

		

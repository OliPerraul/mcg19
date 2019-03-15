
extends 'StateGrounded.gd'

export(float) onready var _SPEED = 50.0
export(float) onready var _DECELERATION = 1.0
export(float) onready var _ACCELERATION = 1.0


func setup(context, args):
	.setup(context, args)
	context.animated_sprite.play("Idle")


func update(context):
	.update(context)	


	
	
		

class_name OLI_STATE_ALERT
#extends OLI_STATE
extends "res://Core/World/AI - Oli/FSM/State.gd"

# GO TO EVENT LOCATION
# (CAR ALARM etc.)

var time_detection = 0
export(float) onready var time_detection_limit_player = 0.5
export(float) onready var time_detection_limit_footprint = 0.5



func setup(context, args):
	time_detection = 0
	pass
	
func clean():
	pass


func update(context, delta):	
	if context.vision.target != null  and context.vision.target.priority > -1:
	
		time_detection += delta	
		match(context.vision.target.type):
			Globals.DETECTABLE.PLAYER:
				if time_detection > time_detection_limit_player:
					print("boop")
					context.fsm.set_state_named('Chase', [context.vision.target])
					context.vision.draw_color = context.vision.RED
				else:
					context.emoji.play('Warning')
					context.vision.draw_color = context.vision.YELLOW
					
				
			Globals.DETECTABLE.FOOTPRINT:
				if time_detection > time_detection_limit_footprint:
					context.fsm.set_state_named('Trace', [context.vision.target])
					context.emoji.play('Warning')
					context.vision.draw_color = context.vision.YELLOW
	else:
		time_detection = 0
		context.emoji.play('Nothing')
		context.vision.draw_color = context.vision.GREEN
	
	
	
	
func physics_update(context, delta):
	pass
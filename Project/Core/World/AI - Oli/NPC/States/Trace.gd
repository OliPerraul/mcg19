extends OLI_STATE_ALERT

"""
extends Node2D

export(float) onready var priority = 100
onready var type = Globals.DETECTABLE.FOOTPRINT

var footprint_stack 
var sprite: Sprite


func _ready():
	add_to_group(detectable)
	#sprite = Sprite.new()
	#sprite.set_texture(load(House1.png))


func _set_reference(ref):
	footprint_stack = ref

func _set_position(pos):
	print(pos)
	global_position = pos
"""
export(float) var SPEED = 100.0
var velocity = Vector2()
var target

var _stk


func setup(context, args):
	target = args[0]
	_stk = target.footprint_stack

func clean():
	pass


func update(context, delta):
	
	## UPD PLAY	
	var last_position = context.global_transform.origin
	context.global_transform.origin = lerp(context.global_transform.origin, context.astar_agent.global_transform.origin, context.lerp_speed)
	context.direction = context.global_transform.origin - last_position
	
	# UPDATE AGENT	
	if len(_stk) == 0:
		context.fsm.set_state_named("Idle")
		return
		
	_move_to(context, _stk[len(_stk)-1].global_position)
		
	if Vectors.close_enough(context.astar_agent.global_position, _stk[len(_stk)-1].global_position, .01):
		_stk.pop_back()
		if len(_stk) == 0:
			context.fsm.set_state_named("Idle")
				
	

func _move_to(context, world_position):
	var MASS = 10.0
	var desired_velocity = (world_position - context.astar_agent.global_position).normalized() * SPEED
	var steering = desired_velocity - velocity
	velocity += steering / MASS
	context.astar_agent.global_position += velocity * get_process_delta_time()
	#rotation = velocity.angle()

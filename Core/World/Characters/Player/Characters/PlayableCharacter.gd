extends Node2D

signal start_moving
signal moving
signal path_changed


# Public
export(NodePath) onready var __controller
var controller

export(NodePath) onready var __animated_sprite
var animated_sprite

export(NodePath) onready var __hit_box
var hit_box

export(NodePath) onready var __fsm
var fsm


export(NodePath) onready var __world_collider
var world_collider


var direction = 0 #-1, 0, 1 # TODO Possibly more if airborne 
var velocity = Vector2(0,0)



func _ready():
	controller = get_node(__controller)
	animated_sprite = get_node(__animated_sprite)
	hit_box = get_node(__hit_box)
	fsm = get_node(__fsm)
	world_collider = get_node(__world_collider)
	

func _process(delta):
	orient(Floats.zero_sign(controller.horizontal))
	# Enact state/character specific actions
	fsm.update()
	#world_collider.handle_update(self)
	#world_collider.handle_update(self)
	position += velocity
	position = position.floor()
	world_collider.handle_update(self)
	
	
func _physics_process(delta):
	# Enact state/character specific actions
	fsm.physics_update(delta)
	

#	-1, 0, 1
func orient(direction):
	match direction:
		-1:
			animated_sprite.flip_h = true
		1:
			animated_sprite.flip_h = false


	
	
func _notification(what):
	if NOTIFICATION_PATH_CHANGED :
		emit_signal('path_changed')
	
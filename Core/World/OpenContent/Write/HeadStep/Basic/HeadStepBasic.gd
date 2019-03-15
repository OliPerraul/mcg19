extends 'res://Core/OpenContent/OpenNode.gd'

# TODO refactor with PlayablePlayer..



signal start_moving
signal moving


# Public
export(NodePath) onready var __controller
var controller

export(NodePath) onready var __animated_sprite
var animated_sprite

export(NodePath) onready var __collision_box
var collision_box

export(NodePath) onready var __fsm
var fsm



var direction = 0 #-1, 0, 1 # TODO Possibly more if airborne 

func _ready():
	controller = get_node(__controller)
	animated_sprite = get_node(__animated_sprite)
	collision_box = get_node(__collision_box)
	fsm = get_node(__fsm)
	

# Private

# ...


#Public

#	-1, 0, 1
func orient(direction):
	match direction:
		-1:
			animated_sprite.flip_h = true
		1:
			animated_sprite.flip_h = false

class_name OLI_EVENT
extends Node2D

export(NodePath) onready var __area
var area : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area = get_node(__area)
	connect("_on_area_enter", area, 'area_enter')


var t_scale = Vector2.ONE
export(float) var max_scale = 1.2 
export(float) var scale_speed = .08 

func _process(delta):
	t_scale = Vector2.ONE	
	var overlaps = area.get_overlapping_bodies()
	for o in overlaps:
		if o != null: #TODO safe check for other non contextable areas
			handle(o)
			
	scale = lerp(scale, t_scale, scale_speed)
	



# ABSTRACT : please override
func handle(player):
	pass







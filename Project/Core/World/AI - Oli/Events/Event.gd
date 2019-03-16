class_name OLI_EVENT
extends Node2D

export(NodePath) onready var __area
var area : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area = get_node(__area)
	connect("_on_area_enter", area, 'area_enter')

func _process(delta):
	var overlaps = area.get_overlapping_bodies()
	for o in overlaps:
		if o != null : #TODO safe check for other non contextable areas
			handle(o)
			

# ABSTRACT : please override
func handle(player):
	pass


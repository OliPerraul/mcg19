class_name OLI_EVENT
extends Node2D

export(NodePath) onready var __area
var area : Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	area = get_node(__area)
	area.connect("body_entered", self, '_on_body_entered')
	area.connect("body_exited", self, '_on_body_exited')
   

var t_scale = Vector2.ONE
export(float) var max_scale = 1.2 
export(float) var scale_speed = .08 


func _process(delta):
	
	# Handle stay
	t_scale = Vector2.ONE	
	var overlaps = area.get_overlapping_bodies()
	for o in overlaps:
		if o != null: #TODO safe check for other non contextable areas
			if o.is_in_group('detectable'):
				t_scale = Vector2.ONE*max_scale
				_on_body_stay(o)
			
	scale = lerp(scale, t_scale, scale_speed)
	
	
func _on_body_stay(b):
	pass
	
# ABSTR
func _on_body_entered(b):
	pass


# ABSTR
func _on_body_exited(b):
	pass









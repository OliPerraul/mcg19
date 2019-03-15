extends Area2D


export(NodePath) onready var __detection_box
export(NodePath) onready var __detection_zone
var _detection_zone : Area2D


func _ready():
	_detection_zone = get_node(__detection_zone)
	_detection_zone.connect('area_entered', self, '_on_foreign_hitbox')
		
	


	



class_name OpenNode
extends Node2D


# Hitbox required by the OpenNode
export(NodePath) onready var __hit_box
var hit_box


func _ready():
	hit_box = get_node(__hit_box)


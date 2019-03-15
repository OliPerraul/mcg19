extends Node


export(NodePath) onready var __tile_map
var tile_map

export(NodePath) onready var __background
var background

export(NodePath) onready var __middleground
var middleground

export(NodePath) onready var __foreground
var foreground


func _ready():
	tile_map = get_node(__tile_map)
	background = get_node(__background)
	middleground = get_node(__middleground)
	foreground = get_node(__foreground)

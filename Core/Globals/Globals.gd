extends Node

enum COLLISION_LAYER{
		WALLS =0,
		ENEMIES=1,
		WATER=2
	
	}


var game  = null
var current_camera : Camera2D = null
var canvas_layer : CanvasLayer = null
var world : Node2D = null
var hud : Control = null

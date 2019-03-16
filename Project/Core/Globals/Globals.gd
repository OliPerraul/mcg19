extends Node

enum COLLISION_LAYER{
		WALLS =0,
		ENEMIES=1,
		WATER=2
	
	}
	
	
enum DETECTABLE{
		PLAYER,
		FOOTPRINT,
		ALARM
	}


var game  = null
var events = null

var current_camera : Camera2D = null
var canvas_layer : CanvasLayer = null
var world : Node2D = null
var hud : Control = null
